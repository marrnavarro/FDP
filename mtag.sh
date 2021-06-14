cd /imppc/labs/dnalab/share/mar_navarro/mtag/input/

conda activate mtag

python2.7 ../mtag.py --sumstats brown_eyes.txt,blue_green_eyes.txt,sunburn.txt,freckles.txt,brown_light_eyes.txt,blue_green_light_eyes.txt,black_eyes.txt,hair_color_blond.txt,hair_color_brown.txt,hair_color_black.txt,brown_skin.txt,white_skin.txt,very_white_skin.txt,fototipo_cat.txt,fototipo_score.txt --out /imppc/labs/dnalab/share/mar_navarro/mtag/output/ --n_value 4988,4988,4985,4984,4988,4988,4988,4979,4979,4979,4985,4985,4985,4988,4988 --stream_stdout --force &

