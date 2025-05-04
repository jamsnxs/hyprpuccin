#!/bin/bash

swww-daemon &
sleep 0.5 && swww restore
