import 'package:flutter/material.dart';
import 'package:pangaduan/commons/providers/home_provider.dart';
import 'package:pangaduan/commons/utils/color.dart';
import 'package:pangaduan/resources/models/log_model.dart';
import 'package:pangaduan/commons/extensions/datetime_extension.dart';
import 'package:provider/provider.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    HomeProvider home = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 100,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          color: Colors.white,
          child: Column(
            children: List.generate(home.logs.length, (index) {
              LogModel log = home.logs[index];
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 0),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color: teal,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              (log.createdAt ?? DateTime.now()).toLog(),
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width,
                            child: Text(
                              log.detail,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
