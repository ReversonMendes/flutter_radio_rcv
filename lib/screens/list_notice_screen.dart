import 'package:flutter/material.dart';
import 'package:flutter_radio_rcv/screens/web_view_screen.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../models/failure_model.dart';
import '../models/item_model.dart';
import '../repository/notice_repository.dart';

class ListNoticeScreen extends StatefulWidget {
  const ListNoticeScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ListNoticeScreenState createState() => _ListNoticeScreenState();
}

class _ListNoticeScreenState extends State<ListNoticeScreen> {
  late Future<List<Item>> _futureItems;
  final NoticeRepository noticeRepository = NoticeRepository();
  @override
  void initState() {
    super.initState();
    _futureItems = noticeRepository.getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEBF3),
      body: RefreshIndicator(
        onRefresh: () async {
          _futureItems = noticeRepository.getItems();
          setState(() {});
        },
        child: FutureBuilder<List<Item>>(
          future: _futureItems,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Show pie chart and list view of items.
              final items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];

                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(top: 11),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 242, 245),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 2.0,
                          color: const Color.fromARGB(255, 248, 248, 248),
                          style: BorderStyle.none),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 194, 190, 190),
                          offset: Offset(1, 1),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const Icon(LucideIcons.newspaper),
                      title: Text(item.name,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        ' • ${item.date.day}/${item.date.month}/${item.date.year}',
                        style: const TextStyle(fontSize: 10),
                      ),
                      textColor: Colors.black,
                      onTap: () async {
                        _readNotice(item);
                        setState(() {});
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              //Show failure error message.
              final failure = snapshot.error as Failure;
              return Center(child: Text(failure.message));
            }
            // Show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<void> _readNotice(Item notice) async {
    final navigator = Navigator.of(context);
    await navigator.push(
      MaterialPageRoute(
        builder: (BuildContext context) => WebViewScreen(notice: notice),
      ),
    );
  }
}
