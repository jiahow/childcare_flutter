import 'package:loading_overlay/loading_overlay.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/CustomAppBar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/globals.dart' as globals;
import 'package:flutter_app/PushNotification.dart';

import 'API/Event.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  TextEditingController _eventController;
  TextEditingController _eventDescController;
  CalendarController _calendarController;
  Map<DateTime,List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  SharedPreferences _sharedPreferences;
  int eventCounter;
  String CalendarLang;
  bool _isLoading = true;

  void callback(String lang){
    setState(() {
      CalendarLang = globals.Config.langCode[lang];
      eventCounter = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _events = {};
    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _eventDescController = TextEditingController();
    _selectedEvents = [];
    initPref();
    eventCounter = 0;
    CalendarLang = tr('language');
  }

  void initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      //_events =  Map<DateTime,List<dynamic>>.from(globals.decodeMap(json.decode(_sharedPreferences.getString("events")))??"{}");
    });
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    GetEvent(month: dateParse.month.toString(), year: dateParse.year.toString()).then((EventList) => {
      setState(() {
        EventList.forEach((event) {
          DateFormat formatter = DateFormat('yyyy-MM-dd');
          String date = formatter.format(event.date);
          if(_events[DateTime.parse(date)] == null){
            _events[DateTime.parse(date)] = [];
          }
          _events[DateTime.parse(date)].add([event.id.toString(), event.title, event.body]);
        });
        _isLoading = false;
      }),
    });
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content:
        Row(
          children: [
            Expanded(
                child: SizedBox(
                  height: 180,
                  child: Column(
                      children: [
                        TextField(
                            controller: _eventController,
                            decoration: InputDecoration(
                                labelText: 'Event Title'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 2.0,
                            )
                        ),
                        TextField(
                            controller: _eventDescController,
                            decoration: InputDecoration(
                                labelText: 'Event Reason'
                            ),
                            style: TextStyle(
                              fontSize: 15.0,
                              height: 1.5,
                            )
                        ),
                      ]
                  ),
                )
            ),
          ]
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            onPressed: _addEvent,
          )
        ],
      ),
    );
  }

  _addEvent(){
    if(_eventController.text.isNotEmpty){
      Navigator.pop(context);
      String Title = _eventController.text;
      String Body = _eventDescController.text;
      setState(() {
        _isLoading = true;
      });
      CreateEvent(title: _eventController.text, body: _eventDescController.text, date: _calendarController.selectedDay,
        type: 1).then((event) => {
          setState(() {
            DateFormat formatter = DateFormat('yyyy-MM-dd');
            String date = formatter.format(event.date);
            DateTime SelectedDate = DateTime.parse(date);
            if(_events[SelectedDate] == null){
              _events[SelectedDate] = [];
            }
            _events[SelectedDate].add([event.id, Title , Body]);
            _selectedEvents =_events[SelectedDate];
            _isLoading = false;
          }),
      });
      _eventController.clear();
      _eventDescController.clear();
      //_sharedPreferences.setString("events", json.encode(globals.encodeMap(_events)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: widget.title, callback: callback),
        body: PushNotification(LoadingOverlay(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TableCalendar(
                  events: _events,
                  locale: CalendarLang,
                  calendarController: _calendarController,
                  calendarStyle: CalendarStyle(
                    todayColor: Colors.orangeAccent,
                    todayStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)
                  ),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonVisible: false
                  ),
                  onVisibleDaysChanged: (first, last, format){
                    _events.clear();
                    var dateParse = new DateTime(first.year, first.month + 1, first.day);
                    setState(() {
                      _isLoading = true;
                    });
                    GetEvent(month: dateParse.month.toString(), year: dateParse.year.toString()).then((EventList) => {
                      setState(() {
                        EventList.forEach((event) {
                          DateFormat formatter = DateFormat('yyyy-MM-dd');
                          String date = formatter.format(event.date);
                          DateTime SelectedDate = DateTime.parse(date);
                          if(_events[SelectedDate] == null){
                            _events[SelectedDate] = [];
                          }
                          _events[SelectedDate].add([event.id, event.title, event.body]);
                        });
                        _isLoading = false;
                      }),
                    });
                  },
                  onDaySelected : (date, events, holidays){
                    setState(() {
                      _selectedEvents = events;
                      eventCounter = 0;
                    });
                  },
                ),
                Flexible(
                  child: Container(
                    height: 250,
                    child: SingleChildScrollView(child: Column(
                      children: <Widget>[
                        ... _selectedEvents.map((event) => Card(
                            child: Row(children:<Widget>[
                              Expanded(child: ListTile(
                                title: Text(event[1]),
                                subtitle: Text(event[2]),
                              ),),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.blue[200],
                                  tooltip: "Delete",
                                  onPressed: () => {
                                    setState(() {
                                      _isLoading = true;
                                      DateFormat formatter = DateFormat('yyyy-MM-dd');
                                      String date = formatter.format(_calendarController.selectedDay);
                                      DateTime selectedDate = DateTime.parse(date);
                                      _events[selectedDate].remove(event);
                                      DeleteEvent(id: event[0].toString()).then((event) => {
                                        setState(() {
                                          _isLoading = false;
                                        }),
                                      });
                                      //_sharedPreferences.setString("events", json.encode(globals.encodeMap(_events)));
                                    })
                                  }
                              ),
                            ])
                        ))
                      ],
                    )
                    ),
                  ),
                ),

              ],
            ),
          ),
          isLoading: _isLoading,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
        )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showDialog,
      ),
    );
  }
}