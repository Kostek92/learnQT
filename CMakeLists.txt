cmake_minimum_required(VERSION 3.16)

project(Qml9_player VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Quick Multimedia)


qt_add_executable(appQml9_player
    main.cpp
	PlayerController.h PlayerController.cpp
)

qt_add_qml_module(appQml9_player
    URI Qml9_player
    VERSION 1.0
    QML_FILES Main.qml
	QML_FILES AudioInfoBox.qml
	QML_FILES TextButton.qml
	QML_FILES ImageButton.qml

	SOURCES AudioInfo.h AudioInfo.cpp

	RESOURCES
	assets/images/cover_acdc.png
	assets/images/cover_bong_hits.png
	assets/images/cover_nirvana.png
	assets/images/cover_pink_floyd.png

	assets/icons/app_icon.ico
	assets/icons/next_icon.png
	assets/icons/pause_icon.png
	assets/icons/play_icon.png
	assets/icons/previous_icon.png

	assets/music/dont_boggart_me.mp3
	assets/music/let_me_put_my_love_into_you.mp3
	assets/music/my_girl.mp3

)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appQml9_player PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appQml9_player
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appQml9_player
	PRIVATE Qt6::Quick  Qt6::Multimedia
)

include(GNUInstallDirs)
install(TARGETS appQml9_player
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
