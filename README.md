# EEG Signal Processing
Unipd, Neurorobotics and Neurorehabilitation course, final project

EEG signal processing using Matlab.

## Introduction

The goal of the project is to detect changes in EEG signals before and after a rehabilitation session. 
Resting state

## Material and methods

The initial data are two Matlab structs that contain a 2D array of 64 channel EEG data for 300 seconds at 250 Hz, before and after the session, and a file includes the position of electrodes for each channel. 

As a preprocessing step, first, the data is passed through a bandpass filter with a passband frequency range of 1 and 30 Hz.

Secondly, ICA is used for artifact removal. In order to understand better ICA

For more details, please see the report
