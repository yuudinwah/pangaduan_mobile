import 'package:flutter/material.dart';
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
    // UserModel user = auth.user!;
    HomeProvider home = Provider.of<HomeProvider>(context);
    CaseModel caseModel = home.cases.getCase(widget.id)!;
    String newStatus = '';
    switch (caseModel.status) {
      case 'Menunggu':
        newStatus = 'Proses';
        break;
      default:
        newStatus = 'Selesai';
    }
    return ChangeNotifierProvider<CaseProvider>(
      create: (_) => CaseProvider(widget.id),
      builder: (_, __) {
        return Consumer<CaseProvider>(
          builder: (_, caseProvider, __) {
            if (caseProvider.fullLoad) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => caseProvider.init(auth.token!));
            }
            return Material(
              child: Stack(
                children: [
                  Scaffold(
                    appBar: AppBar(
                      title: const Text('Detail Pengaduan'),
                      actions: [
                        if (caseModel.status != 'Selesai')
                          InkWell(
                            onTap: () async {
                              await caseModel.updateStatus(
                                  newStatus, auth.token!);
                              await home.loadCases(auth.token!);
                              await caseProvider.loadCaseResponse(auth.token!);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    newStatus == "Selesai" ? Colors.blue : teal,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Text(
                                    newStatus,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    body: SmartRefresher(
                      controller: caseProvider.caseController,
                      onRefresh: () =>
                          caseProvider.loadCaseResponse(auth.token!),
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 12,
                                                  ),
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: teal,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: width,
                                            child: Text(
                                              caseModel.detail,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
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
                                children: List.generate(
                                    caseProvider.responds.length, (index) {
                                  CaseResponseModel respond =
                                      caseProvider.responds[index];
                                  UserModel? responded =
                                      home.users.getUser(respond.userID);
                                  // return Text(
                                  //     respond.userID + index.toString());
                                  if (responded == null) {
                                    return const SizedBox();
                                  }
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 36,
                                          width: 36,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Image.asset(
                                              'assets/images/user.png'),
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
                                                      responded.name,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                  ),
                  if (auth.user!.isPetugas() && caseModel.status == "Proses")
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: InkWell(
                        onTap: caseProvider.changeFormStatus,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          height: 40,
                          decoration: BoxDecoration(
                            color: teal,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: const [
                              Text(
                                'Respond',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (caseModel.status == "Proses" && caseProvider.showForm)
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Scaffold(
                        appBar: AppBar(
                          leading: InkWell(
                            onTap: caseProvider.changeFormStatus,
                            child: const Icon(Icons.close),
                          ),
                          title: const Text('Tambah Respon Pengaduan'),
                        ),
                        body: Container(
                          height: height,
                          width: width,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller:
                                      caseProvider.caseRespondController,
                                  maxLines: 99,
                                  minLines: 99,
                                  decoration: const InputDecoration(
                                    hintText:
                                        'Masukkan keterangan status dari pengaduan ini ...',
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    border: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: width,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: SizedBox(),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await caseProvider.sendRespond(auth);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 8,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: newStatus == "Selesai"
                                              ? Colors.blue
                                              : teal,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: const [
                                            Text(
                                              'Kirim',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.send,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
