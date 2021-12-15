CMakeScripts
================

## Table of Contents
- [FetchIfMissing.cmake](#fetchifmissing.cmake)
- [FindTensorRT.cmake](#findtensorrt.cmake)

## [FetchIfMissing.cmake](./FetchIfMissing.cmake)
This module provides a function to fetch a package from a remote server if it is
missing from the system.

Example usage:
```CMake
FetchIfMissing(json
   GIT_REPOSITORY https://github.com/NicolasIRAGNE/nlohmann_json_cmake_fetchcontent
   GIT_TAG nicolasiragne/interface
)
FetchIfMissing(SDL2
  GIT_REPOSITORY "https://github.com/libsdl-org/SDL/"
  GIT_TAG release-2.0.18
)
FetchContent_MakeAvailable(${FETCHED_TARGETS})
```

## [FindTensorRT.cmake](./FindTensorRT.cmake)
Attempts to find TensorRT and its components (usually nvinfer).
Example usage:
```CMake
Find_Package(TensorRT COMPONENTS nvinfer REQUIRED)
target_link_libraries(foo trt::nvinfer)
```

# Notes


#### Code Style
The code style is ass. This is a work in progress. I copied a bit of code from an old existing script which had inconsistent style and I'm too lazy to fix it. Too bad!

#### Contributing
If you use these scripts, please report any bugs or issues. I will try to fix them. If you want to contribute, please fork the repository and submit a pull request. If you want to send me pictures of monkeys, please send them to nicolas.iragne@alyce.fr.