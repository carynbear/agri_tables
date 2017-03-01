#!/usr/bin/env bash


PS3='Which detection would you like to run? : '
options=("Rivers" "Peak" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Rivers")
            echo "You chose Rivers."
            echo "------------------------------------------------------------"
            echo "Enter a pdf file name:"
			read pdf
			docker-compose run --rm extractor python run.py $pdf
            break;;
        "Peak")
            echo "You chose Peak."
            echo "------------------------------------------------------------"
            echo "Enter the folder name where your pdf files exist:"
            read folder
            while true; do
			    read -p "Have you converted your folder of source pdfs yet? [yes or no]: " yn
			    case $yn in
			        [Yy]* ) break;;
			        [Nn]* ) mogrify -format png -density 150 input.pdf -quality 90  -- "$folder/*.pdf"; break;;
			        * ) echo "Please answer yes or no.";;
			    esac
			done
			echo "Press any key to proceed to next view."
			python run_detect.py $folder
            break;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

