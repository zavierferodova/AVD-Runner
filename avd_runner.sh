emulator_path=~/Android/Sdk/emulator/

show_banner() {
  clear
  figlet AVD RUNNER
  echo '==========================================================='
  echo '                              By: Zavier Ferodova Al Fitroh'
  printf '\nSelect Android Virtual Devices To Run :\n\n'
}

get_list_avds() {
 emulator_list=$(${emulator_path}/emulator -list-avds)
 echo ${emulator_list}
}

show_list_avds() {
  emulator_list=$1
  emulator_counter=0
  for emulator in ${emulator_list}; do
   ((emulator_counter++))
   echo "[${emulator_counter}] ${emulator}"
  done
}

select_avd() {
  read -p '~> ' index
  if [ "$index" -eq "$index" ] 2>/dev/null; then
    echo "$index"
  else
    echo -1
  fi  
}

run_avd() {
  selected_index=$(($1 - 1))
  emulator_list=($(get_list_avds))

  # Check ( $selected_index > -1) AND ( $selected_index < size of array $emulator_list )
  if [[ $selected_index -gt -1 ]] && [[ $selected_index -lt ${#emulator_list[@]} ]]; then
    printf "\nRunning ${emulator_list[$selected_index]}\n"
    ${emulator_path}/emulator -avd ${emulator_list[$selected_index]}
  else
    printf "\nAndroid virtual device not available !\n"
  fi
}

show_banner
list_avds=$(get_list_avds)
show_list_avds "${list_avds[@]}"
echo ''
run_avd $(select_avd)
