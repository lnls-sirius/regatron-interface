option(ENABLE_CPPCHECK "Enable static analysis with cppcheck" OFF)
option(ENABLE_CLANG_TIDY "Enable static analysis with clang-tidy" OFF)
option(ENABLE_INCLUDE_WHAT_YOU_USE "Enable static analysis with include-what-you-use" OFF)

if(ENABLE_CPPCHECK)
    find_program(CPPCHECK cppcheck)
    if(CPPCHECK)
        set(CMAKE_CXX_CPPCHECK
            ${CPPCHECK}
            --suppress=missingInclude
            --enable=all
            --inconclusive
            -i
            ${CMAKE_SOURCE_DIR}/imgui/lib)
    else()
        message(SEND_ERROR "cppcheck requested but executable not found")
    endif()
endif()

if(ENABLE_CLANG_TIDY)
    find_program(CLANGTIDY clang-tidy)
    if(CLANGTIDY)
        set(CMAKE_CXX_CLANG_TIDY ${CLANGTIDY} -extra-arg=-Wno-unknown-warning-option)
    else()
        message(SEND_ERROR "clang-tidy requested but executable not found")
    endif()
endif()

# https://include-what-you-use.org/
if(ENABLE_INCLUDE_WHAT_YOU_USE)
    find_program(INCLUDEWHATYOUUSE include-what-you-use)
    if(INCLUDEWHATYOUUSE)
        set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE ${INCLUDEWHATYOUUSE})
    else()
        message(SEND_ERROR "include-what-you-use requested but executable not found")
    endif()
endif()
