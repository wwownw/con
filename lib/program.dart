import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable_view/timetable_view.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          '행사일정',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: TimetableView(
        laneEventsList: _buildLaneEvents(),
        onEventTap: onEventTapCallBack,
        onEmptySlotTap: onTimeSlotTappedCallBack,
        timetableStyle: TimetableStyle(
            startHour: 9,
            endHour: 19,
            laneWidth: 150,
            laneHeight: 50,
            laneColor: Colors.grey.shade100,
            timeItemTextColor: Colors.grey,
            timelineBorderColor: Colors.grey.shade200),
      ),
    );
  }

  List<LaneEvents> _buildLaneEvents() {
    return [
      LaneEvents(
        lane: Lane(
            name: '7월 2일 (1일차)',
            laneIndex: 1,
            backgroundColor: Colors.grey.shade100,
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        events: [
          TableEvent(
            eventId: 11,
            title: '개회식',
            laneIndex: 1,
            location: '\n컨벤션 홀',
            startTime: TableEventTime(hour: 12, minute: 0),
            endTime: TableEventTime(hour: 13, minute: 0),
            backgroundColor: const Color.fromRGBO(20, 10, 100, 170),
          ),
          TableEvent(
            eventId: 12,
            title: '세미나',
            laneIndex: 1,
            location: '\n각 세미나실',
            startTime: TableEventTime(hour: 15, minute: 0),
            endTime: TableEventTime(hour: 17, minute: 20),
            backgroundColor: const Color.fromRGBO(100, 190, 225, 100),
          ),
        ],
      ),
      LaneEvents(
        lane: Lane(
            name: '7월 3일 (2일차)',
            laneIndex: 2,
            backgroundColor: Colors.grey.shade100,
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        events: [
          TableEvent(
            title: 'An event 3',
            laneIndex: 2,
            eventId: 21,
            startTime: TableEventTime(hour: 10, minute: 10),
            endTime: TableEventTime(hour: 11, minute: 45),
            backgroundColor: const Color.fromRGBO(300, 100, 0, 400),
          ),
        ],
      ),
      LaneEvents(
        lane: Lane(
            name: '7월 4일 (3일차)',
            laneIndex: 2,
            backgroundColor: Colors.grey.shade100,
            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        events: [
          TableEvent(
            title: 'An event 3',
            laneIndex: 3,
            eventId: 21,
            startTime: TableEventTime(hour: 13, minute: 10),
            endTime: TableEventTime(hour: 16, minute: 45),
            backgroundColor: const Color.fromRGBO(40, 20, 20, 100),
          ),
        ],
      ),
      LaneEvents(
        lane: Lane(
          name: ' ',
          laneIndex: 4,
          backgroundColor: Colors.grey.shade100,
        ),
        events: [
          TableEvent(
            title: 'An event 3',
            laneIndex: 2,
            eventId: 21,
            startTime: TableEventTime(hour: 13, minute: 10),
            endTime: TableEventTime(hour: 16, minute: 45),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    ];
  }
}

void onEventTapCallBack(TableEvent event) {
  print(
      "Event Clicked!! LaneIndex ${event.laneIndex} Title: ${event.title} StartHour: ${event.startTime.hour} EndHour: ${event.endTime.hour}");
}

void onTimeSlotTappedCallBack(
    int laneIndex, TableEventTime start, TableEventTime end) {
  print(
      "Empty Slot Clicked !! LaneIndex: $laneIndex StartHour: ${start.hour} EndHour: ${end.hour}");
}
