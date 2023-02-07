import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pangaduan/commons/extensions/list_usermodel_extension.dart';
import 'package:pangaduan/commons/providers/app_provider.dart';
import 'package:pangaduan/commons/providers/case_provider.dart';
import 'package:pangaduan/commons/providers/home_provider.dart';
import 'package:pangaduan/commons/utils/color.dart';
import 'package:pangaduan/resources/models/auth_model.dart';
import 'package:pangaduan/resources/models/case_model.dart';
import 'package:pangaduan/resources/models/case_response_model.dart';
import 'package:pangaduan/resources/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:pangaduan/commons/extensions/datetime_extension.dart';
import 'package:pangaduan/commons/extensions/list_casemodel_extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CaseScreen extends StatefulWidget {
  final String id;
  const CaseScreen(this.id, {super.key});

  @override
  State<CaseScreen> createState() => _CaseScreenState();
}

class _CaseScreenState extends State<CaseScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    AuthModel auth = Provider.of<AppProvider>(context).auth;
    UserModel user = auth.user!;
    HomeProvider home = Provider.of<HomeProvider>(context);
    CaseModel caseModel = home.cases.getCase(widget.id)!;
    return ChangeNotifierProvider<CaseProvider>(
      create: (_) => CaseProvider(widget.id),
      builder: (_, __) {
        return Consumer<CaseProvider>(
          builder: (_, caseProvider, __) {
            if (caseProvider.fullLoad) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => caseProvider.init(auth.token!));
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text('Detail Pengaduan'),
              ),
              body: SmartRefresher(
                controller: caseProvider.caseController,
                onRefresh: () => caseProvider.loadCaseResponse(auth.token!),
                child: Builder(builder: (context) {
                  if (caseProvider.fullLoad) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: greyLight,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Image.asset('assets/images/user.png'),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width: width,
                                      child: Row(
                                        children: [
                                          Text(
                                            caseModel.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: teal,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              caseModel.status,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          Text(
                                            (caseModel.createdAt ??
                                                    DateTime.now())
                                                .toLog(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width,
                                      child: Text(
                                        caseModel.detail,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: width,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.turn_left_sharp,
                                            color: grey,
                                            size: 20,
                                          ),
                                          Container(
                                            height: 30,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${caseModel.respond} Respon',
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Column(
                          children: List.generate(caseProvider.responds.length,
                              (index) {
                            CaseResponseModel respond =
                                caseProvider.responds[index];
                            UserModel? responded =
                                home.users.getUser(respond.userID);
                            return Text(respond.userID + index.toString());
                            if (responded == null) {}
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: greyLight,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child:
                                        Image.asset('assets/images/user.png'),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: width,
                                          child: Row(
                                            children: [
                                              Text(
                                                responded!.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const Expanded(
                                                child: SizedBox(),
                                              ),
                                              Text(
                                                (respond.createdAt ??
                                                        DateTime.now())
                                                    .toLog(),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: width,
                                          child: Text(
                                            respond.response,
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
                      ],
                    ),
                  );
                }),
              ),
            );
          },
        );
      },
    );
  }
}
