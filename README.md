# Radar Invader Detection

## Overview
This application analyzes radar images to detect invaders based on specified patterns. The application uses a sliding window approach to identify invaders that may partially appear at the edges of the radar image.

## Features
- **Radar Image Parsing**: Loads radar images from a specified string format.
- **Invader Pattern Matching**: Detects invaders based on their patterns, allowing for adjustable tolerance levels.
- **Edge Detection**: Supports the detection of invaders that are partially visible on the edges of the radar.
- **Variation Support**: Allows detection of invaders in different orientations and positions.

## Requirements
- Ruby
- Bundler

## Installation
1. Clone the repository:
```
git clone <repository-url>
cd <repository-directory>
```
2. Install dependencies:
```
bundle install
```

## Usage
```
ruby main.rb
```
