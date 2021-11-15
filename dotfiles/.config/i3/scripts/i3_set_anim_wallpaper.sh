#!/bin/bash

## Video which will be set as wallpaper in 1st CLI argument:
VIDEO="${1}"

WALLPAPER_DIRECTORY="${HOME}/.wallpaper"


## Check if video was specified:
if [[ -z "${VIDEO}" ]]; then
    echo "ERROR! No video was specified. Please specify video with '${0} <VIDEO>'"
    exit
elif [[ ! -f ${VIDEO} ]]; then
    echo "ERROR! Specified file does not exists or is a directory!"
    exit
fi

## Check if ${WALLPAPER_DIRECTORY} exists, if not create it, if it is normal file, throw error:
if [[ ! -d "${WALLPAPER_DIRECTORY}" ]]; then
    mkdir -p ${WALLPAPER_DIRECTORY}
elif [[ -f "${WALLPAPER_DIRECTORY}" ]]; then
    echo "ERROR! File '${WALLPAPER_DIRECTORY}' exists and is regular file! This file must be directory!"
    exit
fi

## Basename of video file, to create specific directory:
VIDEO_BASENAME=$(basename ${VIDEO})

## Check if subdirectory for specified video exists, if does not exists, then create it:
if [[ -d "${WALLPAPER_DIRECTORY}/${VIDEO_BASENAME}" ]]; then
    echo "Debug: Directory '${WALLPAPER_DIRECTORY}/${VIDEO_BASENAME}' exists."
elif [[ -f "${WALLPAPER_DIRECTORY}/${VIDEO_BASENAME}" ]]; then
    echo "ERROR! File '${WALLPAPER_DIRECTORY}/${VIDEO_BASENAME}' must be directory!"
else
    mkdir -p "${WALLPAPER_DIRECTORY}/${VIDEO_BASENAME}"
fi

## Get Duration and FPS from video:
DURATION=$(ffmpeg -i ${VIDEO} 2>&1 | grep "Duration:" | cut -d ' ' -f 4 | sed "s/,//")
FPS=$(ffmpeg -i ${VIDEO} 2>&1 | grep "fps" | cut -d ',' -f 5 | cut -d ' ' -f 2)

## Check if subdirectory for specific video exists and is empty to avoid creating video from images every time:
if [[ -z "$(ls -A ${WALLPAPER_DIRECTORY}/${VIDEO_BASENAME})" ]]; then
    ### Before creating images from video, check if video is not too long,
    ### or if FPS count is not too high:
    ## Check if file is longer than an hour and minute:
    if [[ $(echo "${DURATION}" | cut -d ":" -f 1) -gt 0 ]]; then
        echo "ERROR! Video is too long! Video must be shorter than 1 minute!"
    elif [[ $(echo "${DURATION}" | cut -d ":" -f 2) -gt 0 ]]; then
        echo "ERROR! Video is too long! Video must be shorter than 1 minute!"
    fi
    ## Check if FPS count is <= 120:
    if [[ ! ${DURATION} -le 120 ]]; then
        echo "ERROR! Video has too much FPS! Maximum allowed FPS value is 120 FPS!"
    fi

    ## If video passed all the tests, create directory for this video:
    mkdir -p "${WALLPAPER_DIRECTORY}/${VIDEO_BASENAME}"

    ## Now convert video to images (expect few Gigabytes):
    ## Note: for JPG anti-aliasing is not working, so low quality.
    ## Note: BMP format is too large.
    ## Note: PNG is still large, but lot better than BMP and anti-aliasing is working.
    ffmpeg -i ${VIDEO} "${WALLPAPER_DIRECTORY}/${VIDEO_BASENAME}/img-%04d.png"
else
    echo "Debug: Directory '${WALLPAPER_DIRECTORY}/${VIDEO_BASENAME}' is not empty."
fi

## Speed in miliseconds:
SPEED=$((1000/${FPS}))

## Get proper value for speed to be used in sleep:
if [[ ${#SPEED} -eq 1 ]]; then
    SPEED="0.00${SPEED}"
elif [[ ${#SPEED} -eq 2 ]]; then
    SPEED="0.0${SPEED}"
elif [[ ${#SPEED} -eq 4 ]]; then
    SPEED="0.${SPEED}"
else
    echo "ERROR! Speed is too slow!"
    exit
fi

## Play images frame by frame in background:
IMAGES=$(ls -1 "${WALLPAPER_DIRECTORY}/${VIDEO_BASENAME}" | wc -l)

## Proper Image name formatting with leading zeros:
for ((i = 1; i <= ${IMAGES}; i++)); do
    IMAGE=${i}
    if [[ ${#IMAGE} -eq 1 ]]; then
        IMAGE="000${IMAGE}"
    elif [[ ${#IMAGE} -eq 2 ]]; then
        IMAGE="00${IMAGE}"
    elif [[ ${#IMAGE} -eq 3 ]]; then
        IMAGE="0${IMAGE}"
    fi
    echo "${IMAGE}"
    feh --force-aliasing --bg-scale "${WALLPAPER_DIRECTORY}/${VIDEO_BASENAME}/img-${IMAGE}.png"
    sleep ${SPEED}

    if [[ i -ge 1800 ]]; then
        i=0
    fi
done

