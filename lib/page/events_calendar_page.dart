import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter_application_pcr_tools/model/activity_event.dart';
import 'package:flutter_application_pcr_tools/service/api_service.dart';
import 'package:flutter_application_pcr_tools/widgets/day_events_bottom_sheet.dart';

const violet = Color(0xff7F51F5);

/// Colors for [EventWidget].
const eventColors = [
  Color(0xff82D964),
  Color(0xffE665FD),
  Color(0xffF7980B),
  Color(0xfff2d232),
  Color(0xffFC6054),
  Color(0xffBEBEBE),
];

extension WeekDayExt on WeekDay {
  String formatCN() {
    var res = "周一";
    switch (this) {
      case WeekDay.sunday:
        res = "周日";
        break;
      case WeekDay.monday:
        res = "周一";
        break;
      case WeekDay.tuesday:
        res = "周二";
        break;
      case WeekDay.wednesday:
        res = "周三";
        break;
      case WeekDay.thursday:
        res = "周四";
        break;
      case WeekDay.friday:
        res = "周五";
        break;
      case WeekDay.saturday:
        res = "周六";
        break;
    }
    return res;
  }
}

class EventsCalendatPage extends StatefulWidget {
  const EventsCalendatPage({Key? key}) : super(key: key);

  @override
  State<EventsCalendatPage> createState() => _EventsCalendatPageState();
}

class _EventsCalendatPageState extends State<EventsCalendatPage> {
  final _currentDate = DateTime.now();

  late CrCalendarController _calendarController;
  late String _monthName;

  List<ActivityEvents> _data = [];

  _getActivityEventData() async {
    var d = await ApiService.getActivityEvents();
    _data = d;
    _createExampleEvents();
    setState(() {});
  }

  @override
  void initState() {
    _setTexts(_currentDate.year, _currentDate.month);

    _getActivityEventData();

    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("事件"),
        actions: [
          IconButton(
            tooltip: 'Go to current date',
            icon: const Icon(Icons.calendar_today),
            onPressed: _showCurrentMonth,
          ),
        ],
      ),
      body: _data.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                /// Calendar control row.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        _changeCalendarPage(showNext: false);
                      },
                    ),
                    Text(
                      _monthName,
                      style: const TextStyle(
                          fontSize: 16,
                          color: violet,
                          fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        _changeCalendarPage(showNext: true);
                      },
                    ),
                  ],
                ),

                /// Calendar view.
                Expanded(
                  child: CrCalendar(
                    firstDayOfWeek: WeekDay.sunday,
                    eventsTopPadding: 32,
                    initialDate: _currentDate,
                    maxEventLines: 3,
                    controller: _calendarController,
                    forceSixWeek: true,
                    dayItemBuilder: (builderArgument) =>
                        DayItemWidget(properties: builderArgument),
                    weekDaysBuilder: (day) {
                      return Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            day.formatCN(),
                            style: TextStyle(
                              color: violet.withOpacity(0.9),
                            ),
                          ),
                        ),
                      );
                    },
                    eventBuilder: (drawer) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          color: drawer.backgroundColor,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            drawer.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    onDayClicked: _showDayEventsInModalSheet,
                    minDate:
                        DateTime.now().subtract(const Duration(days: 1000)),
                    maxDate: DateTime.now().add(const Duration(days: 180)),
                  ),
                ),
              ],
            ),
    );
  }

  /// Control calendar with arrow buttons.
  void _changeCalendarPage({required bool showNext}) => showNext
      ? _calendarController.swipeToNextMonth()
      : _calendarController.swipeToPreviousPage();

  void _onCalendarPageChanged(int year, int month) {
    setState(() {
      _setTexts(year, month);
    });
  }

  /// Set app bar text and month name over calendar.
  void _setTexts(int year, int month) {
    final date = DateTime(year, month);
    _monthName = date.format(kMonthFormat);
  }

  /// Show current month page.
  void _showCurrentMonth() {
    _calendarController.goToDate(_currentDate);
  }

  /// Show [CreateEventDialog] with settings for new event.
  // Future<void> _addEvent() async {
  //   final event = await showDialog(
  //       context: context, builder: (context) => const CreateEventDialog());
  //   if (event != null) {
  //     _calendarController.addEvent(event);
  //   }
  // }

  void _createExampleEvents() {
    _calendarController = CrCalendarController(
      onSwipe: _onCalendarPageChanged,
      events: _data
          .map((e) => CalendarEventModel(
                name: e.title,
                begin: DateTime.parse(e.startTime),
                end: DateTime.parse(e.endTime),
                eventColor: eventColors[e.type],
              ))
          .toList(),
    );
  }

  void _showDayEventsInModalSheet(
      List<CalendarEventModel> events, DateTime day) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
        isScrollControlled: true,
        context: context,
        builder: (context) => DayEventsBottomSheet(
              events: events,
              day: day,
              screenHeight: MediaQuery.of(context).size.height,
            ));
  }
}

/// Widget of day item cell for calendar
class DayItemWidget extends StatelessWidget {
  const DayItemWidget({
    required this.properties,
    Key? key,
  }) : super(key: key);

  final DayItemProperties properties;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: violet.withOpacity(0.3), width: 0.3)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 4),
            alignment: Alignment.topCenter,
            child: Container(
              height: 23,
              width: 23,
              decoration: BoxDecoration(
                color: properties.isCurrentDay ? violet : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${properties.dayNumber}',
                  style: TextStyle(
                    color: properties.isCurrentDay
                        ? Colors.white
                        : violet.withOpacity(properties.isInMonth ? 1 : 0.5),
                    fontWeight: properties.isInMonth
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          if (properties.notFittedEventsCount > 0)
            Container(
              padding: const EdgeInsets.only(right: 2, top: 2),
              alignment: Alignment.topRight,
              child: Text(
                '+${properties.notFittedEventsCount}',
                style: TextStyle(
                  fontSize: 10,
                  color: violet.withOpacity(properties.isInMonth ? 1 : 0.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
