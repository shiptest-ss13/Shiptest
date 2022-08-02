#define MAX_PAPER_LENGTH 5000
#define MAX_PAPER_STAMPS 30 // Too low?
#define MAX_PAPER_STAMPS_OVERLAYS 4
#define MODE_READING 0
#define MODE_WRITING 1
#define MODE_STAMPING 2

///Index access defines for paper/var/add_info_style
#define ADD_INFO_COLOR 1
#define ADD_INFO_FONT 2
#define ADD_INFO_SIGN 3

///Adds a html style to a text string. Hacky, but that's how inputted text appear on paper sheets after going through the UI.
#define PAPER_MARK_TEXT(text, color, font) "<span style=\"color:[color];font-family:'[font]';\">[text]</span>\n \n"
