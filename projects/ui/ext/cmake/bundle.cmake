set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CONFIG}} )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CONFIG}} )
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CONFIG}} )
fixup_bundle("${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/BioGears${CONFIG_SUFFIX}${CMAKE_EXECUTABLE_SUFFIX}"
                 ""
                 "${${ROOT_PROJECT_NAME}_THIRD_PARTY_LIB};${${ROOT_PROJECT_NAME}_THIRD_PARTY_BIN}"
)
