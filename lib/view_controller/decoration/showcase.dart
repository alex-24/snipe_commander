import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

enum ShowCaseElement {
  // top level
  ROOT_HAMBURGER_MENU_BUTTON,

  // open app screen (first time)
  HOME_QUICKSTART_LAUNCHER_BUTTON,
  HOME_OPTIONS_MENU,
  HOME_QUICKSTART_LAUNCHER_MAGAZINE,

  // open app (after one magazine consulted)
  HOME_LAST_USED_LAUNCHER_MAGAZINE,

  // quick start panel
  QUICKSTART_ADD_MAGAZINE,
  QUICKSTART_REMOVE_MAGAZINE,
  QUICKSTART_MOVE_MAGAZINE,

  // add magazine modal
  ADD_MAGAZINE_SELECT_COLOR,
  ADD_MAGAZINE_SELECT_DEFAULT_TIMESCALE,
  ADD_MAGAZINE_CONFIRMATION_BUTTON,

  // artlcle list (magazine was selected)
  ARTICLE_LIST_EDIT_MAGAZINE,
  ARTICLE_LIST_SELECT_TIMESCALE,
  ARTICLE_LIST_SELECT_DATE,
  ARTICLE_LIST_ADD_ARTICLE_BY_PLACEHOLDER_BUTTON,
  ARTICLE_LIST_ADD_ARTICLE_ACTION_BUTTON,

  // add article modal
  ADD_ARTICLE_BACK_BUTTON,
  ADD_ARTICLE_CLEAR_TEXT_BUTTON,
  ADD_ARTICLE_ADD_TIMESTAMP_BUTTON,
  ADD_ARTICLE_MORE_ACTIONS_BUTTON,
  ADD_ARTICLE_SELECT_TIMESCALE,
  ADD_ARTICLE_SAVE_TEMPLATE_BUTTON,
  ADD_ARTICLE_LOAD_TEMPLATE_BUTTON,
  ADD_ARTICLE_CONFIRMATION_BUTTON,

  // save template modal
  SAVE_TEMPLATE_SELECT_TIMESCALE,
  SAVE_TEMPLATE_LOCK_TO_MAGAZINE,

  // load template modal
  LOAD_TEMPLATE_SPECIFIC,
  LOAD_TEMPLATE_NON_SPECIFIC,

  // article list article was created
  ARTICLE_LIST_ARTICLE_WIDGET,

  // side nav menu
  SIDE_NAV_SEARCH,
  SIDE_NAV_TAGS,
  SIDE_NAV_ARCHIVES,
  SIDE_NAV_THEME_SWITCHER,
  SIDE_NAV_CONTACT,
  SIDE_NAV_FEEDBACK,

  //archives
  ARCHIVES_ROOT_FOLDER,
  ARCHIVES_ADD_FOLDER_BUTTON,
  ARCHIVES_ADD_MAGAZINE_TO_QUICKSTART,
  ARCHIVES_ELEMENT_ACTIONS,
  ARCHIVES_OPEN_MAGAZINE_IN_NEW_WINDOW,

  // TODO: Tags, Search
}

extension ShowCaseElementExtension on ShowCaseElement {
  String get name {
    return this.toString().split('.').last.toLowerCase();
  }

  String get title {
    switch (this) {
      case ShowCaseElement.ROOT_HAMBURGER_MENU_BUTTON:
        return "Main menu";

      case ShowCaseElement.HOME_QUICKSTART_LAUNCHER_BUTTON:
        return "Quick Access";

      case ShowCaseElement.HOME_QUICKSTART_LAUNCHER_MAGAZINE:
        return "Let's start";

      case ShowCaseElement.HOME_OPTIONS_MENU:
        return "Options";

      case ShowCaseElement.HOME_LAST_USED_LAUNCHER_MAGAZINE:
        return "Last opened magazine";

      case ShowCaseElement.QUICKSTART_ADD_MAGAZINE:
        return "Create and add a magazine";

      case ShowCaseElement.QUICKSTART_REMOVE_MAGAZINE:
        return "Remove from panel";

      case ShowCaseElement.QUICKSTART_MOVE_MAGAZINE:
        return "Move a magazine";

      case ShowCaseElement.ADD_MAGAZINE_SELECT_COLOR:
        return "Choose a main color";

      case ShowCaseElement.ADD_MAGAZINE_SELECT_DEFAULT_TIMESCALE:
        return "Choose a default period";

      case ShowCaseElement.ADD_MAGAZINE_CONFIRMATION_BUTTON:
        return "Confirm";

      case ShowCaseElement.ARTICLE_LIST_EDIT_MAGAZINE:
        return "Edit the magazine";

      case ShowCaseElement.ARTICLE_LIST_SELECT_TIMESCALE:
        return "Set the display timescale";

      case ShowCaseElement.ARTICLE_LIST_SELECT_DATE:
        return "Change the display date";

      case ShowCaseElement.ARTICLE_LIST_ADD_ARTICLE_BY_PLACEHOLDER_BUTTON:
        return "Add an article";

      case ShowCaseElement.ARTICLE_LIST_ADD_ARTICLE_ACTION_BUTTON:
        return "Add an article";

      case ShowCaseElement.ADD_ARTICLE_BACK_BUTTON:
        return "Go back to the previous screen";

      case ShowCaseElement.ADD_ARTICLE_CLEAR_TEXT_BUTTON:
        return "Clear all the text you've written";

      case ShowCaseElement.ADD_ARTICLE_ADD_TIMESTAMP_BUTTON:
        return "Add a timestamp of the current date at the end";

      case ShowCaseElement.ADD_ARTICLE_MORE_ACTIONS_BUTTON:
        return "Find some more actions here";

      case ShowCaseElement.ADD_ARTICLE_SELECT_TIMESCALE:
        return "Set the timescales";

      case ShowCaseElement.ADD_ARTICLE_SAVE_TEMPLATE_BUTTON:
        return "Save article as a template";

      case ShowCaseElement.ADD_ARTICLE_LOAD_TEMPLATE_BUTTON:
        return "Load article from templates";

      case ShowCaseElement.ADD_ARTICLE_CONFIRMATION_BUTTON:
        return "Save your article";

      case ShowCaseElement.SAVE_TEMPLATE_SELECT_TIMESCALE:
        return "Set the template timescales";

      case ShowCaseElement.SAVE_TEMPLATE_LOCK_TO_MAGAZINE:
        return "Lock the template to this magazine or not";

      case ShowCaseElement.LOAD_TEMPLATE_SPECIFIC:
        return "Load from this magazine's templates";

      case ShowCaseElement.LOAD_TEMPLATE_NON_SPECIFIC:
        return "Load from global templates";

      case ShowCaseElement.ARTICLE_LIST_ARTICLE_WIDGET:
        return "This is your article";

      case ShowCaseElement.SIDE_NAV_SEARCH:
        return "Search for an article";

      case ShowCaseElement.SIDE_NAV_TAGS:
        return "View and manage the tags you've created";

      case ShowCaseElement.SIDE_NAV_ARCHIVES:
        return "Manage all your magazines";

      case ShowCaseElement.SIDE_NAV_THEME_SWITCHER:
        return "Switch the them to dark or back";

      case ShowCaseElement.SIDE_NAV_CONTACT:
        return "Want to reach out ?";

      case ShowCaseElement.SIDE_NAV_FEEDBACK:
        return "Have an issue ?";

      case ShowCaseElement.ARCHIVES_ROOT_FOLDER:
        return "Root archive folder";

      case ShowCaseElement.ARCHIVES_ADD_FOLDER_BUTTON:
        return "Add a new folder";

      case ShowCaseElement.ARCHIVES_ADD_MAGAZINE_TO_QUICKSTART:
        return "Add magazine to quick start";

      case ShowCaseElement.ARCHIVES_ELEMENT_ACTIONS:
        return "Archive actions";

      case ShowCaseElement.ARCHIVES_OPEN_MAGAZINE_IN_NEW_WINDOW:
        return "Open magazine in new window";
    }
  }

  String get subtitle {
    switch (this) {
      case ShowCaseElement.ROOT_HAMBURGER_MENU_BUTTON:
        return "You know that already";

      case ShowCaseElement.HOME_QUICKSTART_LAUNCHER_BUTTON:
        return "Find your pinned magazines here.";

      case ShowCaseElement.HOME_QUICKSTART_LAUNCHER_MAGAZINE:
        return "Create your first magazine.";

      case ShowCaseElement.HOME_OPTIONS_MENU:
        return "Find various settings here.";

      case ShowCaseElement.HOME_LAST_USED_LAUNCHER_MAGAZINE:
        return "This is the last magazine you used";

      case ShowCaseElement.QUICKSTART_ADD_MAGAZINE:
        return "";

      case ShowCaseElement.QUICKSTART_REMOVE_MAGAZINE:
        return "";

      case ShowCaseElement.QUICKSTART_MOVE_MAGAZINE:
        return "";

      case ShowCaseElement.ADD_MAGAZINE_SELECT_COLOR:
        return "";

      case ShowCaseElement.ADD_MAGAZINE_SELECT_DEFAULT_TIMESCALE:
        return "";

      case ShowCaseElement.ADD_MAGAZINE_CONFIRMATION_BUTTON:
        return "";

      case ShowCaseElement.ARTICLE_LIST_EDIT_MAGAZINE:
        return "";

      case ShowCaseElement.ARTICLE_LIST_SELECT_TIMESCALE:
        return "";

      case ShowCaseElement.ARTICLE_LIST_SELECT_DATE:
        return "Swipe horizontally to change quickly or tap to open date picker";

      case ShowCaseElement.ARTICLE_LIST_ADD_ARTICLE_BY_PLACEHOLDER_BUTTON:
        return "this placeholder shows on empty periods";

      case ShowCaseElement.ARTICLE_LIST_ADD_ARTICLE_ACTION_BUTTON:
        return "Alternatively you can tap here";

      case ShowCaseElement.ADD_ARTICLE_BACK_BUTTON:
        return "(your draft is temporarily saved if you come back without changing anything.)";

      case ShowCaseElement.ADD_ARTICLE_CLEAR_TEXT_BUTTON:
        return "Careful, there is no undo button";

      case ShowCaseElement.ADD_ARTICLE_ADD_TIMESTAMP_BUTTON:
        return "Useful if you come back later to add something";

      case ShowCaseElement.ADD_ARTICLE_MORE_ACTIONS_BUTTON:
        return "You can add tags or favourite";

      case ShowCaseElement.ADD_ARTICLE_SELECT_TIMESCALE:
        return "If you set multiple, the article wil be visible at multiple levels";

      case ShowCaseElement.ADD_ARTICLE_SAVE_TEMPLATE_BUTTON:
        return "Do you write some repetitive things?";

      case ShowCaseElement.ADD_ARTICLE_LOAD_TEMPLATE_BUTTON:
        return "Everything is here don't worry.";

      case ShowCaseElement.ADD_ARTICLE_CONFIRMATION_BUTTON:
        return "Don't forget to save when you're done.";

      case ShowCaseElement.SAVE_TEMPLATE_SELECT_TIMESCALE:
        return "The article will be set the same on load.";

      case ShowCaseElement.SAVE_TEMPLATE_LOCK_TO_MAGAZINE:
        return "Helps unclutter the view in other magazines";

      case ShowCaseElement.LOAD_TEMPLATE_SPECIFIC:
        return "AKA the templates for this magazine";

      case ShowCaseElement.LOAD_TEMPLATE_NON_SPECIFIC:
        return "AKA the templates for no magazine in particular";

      case ShowCaseElement.ARTICLE_LIST_ARTICLE_WIDGET:
        return "Swipe left to delete or share.\nDouble tap to view in full.\nLong press to edit.";

      case ShowCaseElement.SIDE_NAV_SEARCH:
        return "Lost something ?";

      case ShowCaseElement.SIDE_NAV_TAGS:
        return "You can also view tags or follow your lines of thought on a topic throughout time.";

      case ShowCaseElement.SIDE_NAV_ARCHIVES:
        return "This is where to find all past, current and future magazines.";

      case ShowCaseElement.SIDE_NAV_THEME_SWITCHER:
        return "Take care of your eyes.";

      case ShowCaseElement.SIDE_NAV_CONTACT:
        return "";

      case ShowCaseElement.SIDE_NAV_FEEDBACK:
        return "Tell us about it.";

      case ShowCaseElement.ARCHIVES_ROOT_FOLDER:
        return "Pretty isn't it?";

      case ShowCaseElement.ARCHIVES_ADD_FOLDER_BUTTON:
        return "More folders = More good ?";

      case ShowCaseElement.ARCHIVES_ADD_MAGAZINE_TO_QUICKSTART:
        return "So you can focus on what matters now.";

      case ShowCaseElement.ARCHIVES_ELEMENT_ACTIONS:
        return "Move, Edit/Rename, Delete";

      case ShowCaseElement.ARCHIVES_OPEN_MAGAZINE_IN_NEW_WINDOW:
        return "Everything still works the same.";
    }
  }
}

enum ShowCaseElementGroup {
  OPEN_APP_1,
  OPEN_APP_2,
  QUICKSTART_PANEL,
  ADD_MAGAZINE_MODAL,
  ARTICLE_LIST,
  ADD_ARTICLE_MODAL,
  SAVE_TEMPLATE_MODAL,
  LOAD_TEMPLATE_MODAL,
  SIDE_NAVIGATION,
}

extension ShowCaseElementGroupExtension on ShowCaseElementGroup {
  String get name {
    return this.toString().split('.').last.toLowerCase();
  }

  List<ShowCaseElement> get elements {
    switch (this) {
      case ShowCaseElementGroup.OPEN_APP_1:
        return [
          ShowCaseElement.HOME_QUICKSTART_LAUNCHER_BUTTON,
          ShowCaseElement.HOME_OPTIONS_MENU,
          ShowCaseElement.HOME_QUICKSTART_LAUNCHER_MAGAZINE,
        ];

      case ShowCaseElementGroup.OPEN_APP_2:
        return [
          ShowCaseElement.HOME_LAST_USED_LAUNCHER_MAGAZINE,
        ];

      case ShowCaseElementGroup.QUICKSTART_PANEL:
        return [
          ShowCaseElement.QUICKSTART_ADD_MAGAZINE,
          ShowCaseElement.QUICKSTART_REMOVE_MAGAZINE,
          ShowCaseElement.QUICKSTART_MOVE_MAGAZINE,
        ];

      case ShowCaseElementGroup.ADD_MAGAZINE_MODAL:
        return [
          ShowCaseElement.ADD_MAGAZINE_SELECT_COLOR,
          ShowCaseElement.ADD_MAGAZINE_SELECT_DEFAULT_TIMESCALE,
          ShowCaseElement.ADD_MAGAZINE_CONFIRMATION_BUTTON,
        ];

      case ShowCaseElementGroup.ARTICLE_LIST:
        return [
          ShowCaseElement.ARTICLE_LIST_EDIT_MAGAZINE,
          ShowCaseElement.ARTICLE_LIST_ADD_ARTICLE_BY_PLACEHOLDER_BUTTON,
          ShowCaseElement.ARTICLE_LIST_SELECT_TIMESCALE,
          ShowCaseElement.ARTICLE_LIST_SELECT_DATE,
          ShowCaseElement.ARTICLE_LIST_ADD_ARTICLE_ACTION_BUTTON,
        ];

      case ShowCaseElementGroup.ADD_ARTICLE_MODAL:
        return [
          //ShowCaseElement.ADD_ARTICLE_BACK_BUTTON,
          ShowCaseElement.ADD_ARTICLE_CLEAR_TEXT_BUTTON,
          ShowCaseElement.ADD_ARTICLE_ADD_TIMESTAMP_BUTTON,
          ShowCaseElement.ADD_ARTICLE_MORE_ACTIONS_BUTTON,
          ShowCaseElement.ADD_ARTICLE_SELECT_TIMESCALE,
          ShowCaseElement.ADD_ARTICLE_SAVE_TEMPLATE_BUTTON,
          ShowCaseElement.ADD_ARTICLE_LOAD_TEMPLATE_BUTTON,
          ShowCaseElement.ADD_ARTICLE_CONFIRMATION_BUTTON,
        ];

      case ShowCaseElementGroup.SAVE_TEMPLATE_MODAL:
        return [
          ShowCaseElement.SAVE_TEMPLATE_SELECT_TIMESCALE,
          ShowCaseElement.SAVE_TEMPLATE_LOCK_TO_MAGAZINE,
        ];

      case ShowCaseElementGroup.LOAD_TEMPLATE_MODAL:
        return [
          ShowCaseElement.LOAD_TEMPLATE_SPECIFIC,
          ShowCaseElement.LOAD_TEMPLATE_NON_SPECIFIC,
        ];

      case ShowCaseElementGroup.SIDE_NAVIGATION:
        return [
          ShowCaseElement.SIDE_NAV_SEARCH,
          ShowCaseElement.SIDE_NAV_TAGS,
          ShowCaseElement.SIDE_NAV_ARCHIVES,
          ShowCaseElement.SIDE_NAV_THEME_SWITCHER,
          ShowCaseElement.SIDE_NAV_CONTACT,
          ShowCaseElement.SIDE_NAV_FEEDBACK,
        ];
    }
  }
}

class ShowCaseUtils {
  static final ShowCaseUtils _singleton = ShowCaseUtils._internal();
  List<GlobalKey> globalKeys = [];
  static const isFirstLaunchPrefKeyPrefix = 'is_first_launch';

  factory ShowCaseUtils() {
    return _singleton;
  }

  ShowCaseUtils._internal() {
    // print("-------------------------------------------??????");
    for (ShowCaseElement element in ShowCaseElement.values) {
      this.globalKeys.add(GlobalKey(debugLabel: element.name));
    }
  }

  Future<bool> _isFirstLaunch(ShowCaseElementGroup group) async {
    //return true;

    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences.getBool(
            "${ShowCaseUtils.isFirstLaunchPrefKeyPrefix}_${group.name}") ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          "${ShowCaseUtils.isFirstLaunchPrefKeyPrefix}_${group.name}", false);

    return isFirstLaunch;
  }

  GlobalKey getGlobalKey(ShowCaseElement element) {
    return globalKeys[ShowCaseElement.values.indexOf(element)];
  }

  List<GlobalKey> getSequence(ShowCaseElementGroup group) {
    List<GlobalKey> res = [];

    for (ShowCaseElement element in group.elements) {
      res.add(getGlobalKey(element));
    }

    return res;
  }

  playTutorialIfFirstLaunch(
      BuildContext context, ShowCaseElementGroup group) async {
    bool isFirstLaunch = await _isFirstLaunch(group);

    if (isFirstLaunch)
      ShowCaseWidget.of(context)
          .startShowCase(ShowCaseUtils().getSequence(group));
  }
}

class ShowCaseBypasser extends StatelessWidget {
  final bool shouldActivateShowCase;
  final ShowCaseElement showCaseElement;
  final Widget child;

  const ShowCaseBypasser({
    Key? key,
    required this.shouldActivateShowCase,
    required this.showCaseElement,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!this.shouldActivateShowCase)
        ? Container(
            child: this.child,
          )
        : Showcase(
            key: ShowCaseUtils().getGlobalKey(this.showCaseElement),
            title: this.showCaseElement.title,
            description: this.showCaseElement.subtitle,
            showArrow: true,
            contentPadding: EdgeInsets.all(8.0),
            shapeBorder: CircleBorder(),
            child: this.child,
          );
  }
}
