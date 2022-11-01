#!/bin/bash
condition=true
counter=1
while [[ $condition ]]; do
  echo ${counter}
  if (($counter == 5)); then
	  break
  fi
  ((counter++))
done

