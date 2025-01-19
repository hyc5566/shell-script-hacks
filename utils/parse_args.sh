#!/bin/bash
# parse_args.sh

# to avoid ^^ & ,, is not defined in bash with old version (after Bash 4.0)
# so we use to_upper & to_lower to avoid this issue
to_upper() {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}
to_lower() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

if [ -z "$PARSE_ARGS_LOADED" ]; then
    PARSE_ARGS_LOADED=1

    # 啟用調試模式
    DEBUG_PARSE_ARGS=${DEBUG_PARSE_ARGS:-0}

    debug_log() {
        if [ "$DEBUG_PARSE_ARGS" = "1" ]; then
            echo "DEBUG: $*" >&2
        fi
    }

    # 獲取調用者腳本的完整路徑和名稱
    get_caller_info() {
        # 遍歷整個調用堆疊來找到真正的調用者
        local stack
        local i=0
        while caller $i > /dev/null 2>&1; do
            stack[i]=$(caller $i)
            ((i++))
        done
        
        # 獲取最後一個調用者（實際的腳本）
        local last_caller="${stack[$((i-1))]}"
        local script_path=$(echo "$last_caller" | awk '{print $3}')
        local abs_path=$(readlink -f "$script_path" 2>/dev/null || echo "$script_path")
        local script_id=$(echo "${abs_path}" | md5 -q 2>/dev/null || md5sum | cut -c1-16)
        
        debug_log "Call stack depth: $i"
        debug_log "Last caller: $last_caller"
        debug_log "Script path: $script_path"
        debug_log "Absolute path: $abs_path"
        debug_log "Generated ID: $script_id"
        
        echo "$script_id"
    }

    # 為每個腳本創建獨立的參數空間
    declare -A SCRIPT_PARAMS 2>/dev/null || SCRIPT_PARAMS=""

    parse_args() {
        local caller_id="$(get_caller_info)"
        debug_log "Parsing args for script ID: $caller_id"
        debug_log "Received arguments: $*"

        local param_defs=()
        local args=()
        local parse_mode="defs"

        # 創建參數存儲空間
        eval "declare -A ARGS_${caller_id} 2>/dev/null || ARGS_${caller_id}=''"

        # 首先，收集所有參數定義（在 -- 之前的部分）
        local all_args=("$@")
        local i=0
        for arg in "${all_args[@]}"; do
            if [ "$arg" = "--" ]; then
                break
            fi
            # 移除任何可能的逗號
            arg="${arg%,}"
            if [[ "$arg" =~ ^[a-zA-Z][a-zA-Z0-9_-]*$ ]]; then
                param_defs+=(\"$arg\")
                debug_log "Added parameter definition: $arg"
            else
                echo "Error: Invalid parameter definition: $arg"
                return 1
            fi
            ((i++))
        done

        # 跳過分隔符 --
        ((i++))

        # 處理實際的參數值
        while [ $i -lt ${#all_args[@]} ]; do
            local arg="${all_args[$i]}"
            debug_log "Processing argument: $arg"

            if [[ "$arg" =~ ^--([a-zA-Z][a-zA-Z0-9_-]*)=(.*)$ ]]; then
                local param_name="${BASH_REMATCH[1]}"
                local param_value="${BASH_REMATCH[2]}"
                args+=(\"--${param_name}=${param_value}\")
                debug_log "Added argument (format1): --${param_name}=${param_value}"
            elif [[ "$arg" =~ ^--([a-zA-Z][a-zA-Z0-9_-]*)$ ]]; then
                local param_name="${BASH_REMATCH[1]}"
                ((i++))
                if [ $i -ge ${#all_args[@]} ]; then
                    echo "Error: Missing value for parameter: $param_name"
                    return 1
                fi
                local param_value="${all_args[$i]}"
                args+=(\"--${param_name}=${param_value}\")
                debug_log "Added argument (format2): --${param_name}=${param_value}"
            else
                args+=(\"$arg\")
                debug_log "Added raw argument: $arg"
            fi
            ((i++))
        done

        # 驗證參數
        if [ ${#param_defs[@]} -eq 0 ]; then
            echo "Error: No parameter definitions provided"
            return 1
        fi

        debug_log "Parameter definitions: ${param_defs[*]}"
        debug_log "Arguments to process: ${args[*]}"

        # 解析和存儲參數
        for arg in "${args[@]}"; do
            local found=0
            for def in "${param_defs[@]}"; do
                def=$(eval echo $def)  # 解除引號
                if [[ "$arg" =~ ^--"$def"=(.*) ]]; then
                    local value="${BASH_REMATCH[1]}"
                    if [ -z "$value" ]; then
                        echo "Error: Empty value for parameter: $def"
                        return 1
                    fi
                    local var_name="${def//-/_}"
                    var_name=$(to_upper "${var_name}")
                    eval "ARGS_${caller_id}_${var_name}='${value}'"
                    debug_log "Set ARGS_${caller_id}_${var_name}='$value'"
                    found=1
                    break
                fi
            done
            if [ $found -eq 0 ] && [[ "$arg" =~ ^-- ]]; then
                echo "Error: Unknown parameter: $arg"
                echo "Allowed parameters: ${param_defs[*]}"
                return 1
            fi
        done

        # 保存參數定義列表
        eval "SCRIPT_PARAMS_${caller_id}='${param_defs[*]}'"
        debug_log "Saved parameter definitions for $caller_id: ${param_defs[*]}"
    }

    # 獲取參數值
    get_arg() {
        local caller_id="$(get_caller_info)"
        local param_name="$1"
        local default_value="$2"
        local name="${param_name//-/_}"
        name=$(to_upper "${name}")
        
        debug_log "Getting arg: caller_id=$caller_id, param=$param_name, normalized=$name"
        
        local value
        eval "value=\$ARGS_${caller_id}_${name}"
        debug_log "Retrieved value: $value"

        if [ -z "$value" ]; then
            if [ -n "$default_value" ]; then
                echo "$default_value"
                return 0
            else
                return 1
            fi
        fi
        echo "$value"
        return 0
    }

    # 檢查參數是否存在
    has_arg() {
        local caller_id="$(get_caller_info)"
        local param_name="$1"
        local name="${param_name//-/_}"
        name=$(to_upper "${name}")
        eval "[ -n \"\$ARGS_${caller_id}_${name}\" ]"
    }
fi

# 顯示使用說明
show_usage() {
    echo "Parameters can be specified in two ways:"
    echo "  1. --parameter-name=value"
    echo "  2. --parameter-name value"
    echo "In a script.sh, source this parse_args.sh and use parse_args to define arguments:"
    echo "  parse_args \"param1\" \"param2\" -- \"\$@\""
    echo "Then use get_arg to get the value of a parameter:"
    echo "  value1=\$(get_arg param1 \"default_value\")"
    echo "  value2=\$(get_arg param2)"
    echo "Or use has_arg to check if a parameter exists:"
    echo "  if has_arg param1; then"
    echo "    echo \"param1 is set\""
    echo "  fi"
}
