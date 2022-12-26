import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tren_boong_concept/domain/bloc/authentication/authentication_event.dart';
import 'package:tren_boong_concept/domain/entity/user_entity.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/bloc/authentication/authentication_bloc.dart';
import '../../../domain/bloc/authentication/authentication_state.dart';
import '../../../infrastructure/remote_source/api_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserSettingDetail extends StatefulWidget {
  const UserSettingDetail({super.key});

  @override
  State<UserSettingDetail> createState() => _UserSettingDetailState();
}

class _UserSettingDetailState extends State<UserSettingDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool editMode = false;
  late UserEntity _userEntity;
  XFile? _xFile;
  File? _file;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        _userEntity = state.user!;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 234, 146, 57),
            title: Text(AppLocalizations.of(context)!.profile,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            actions: [
              Align(
                  alignment: Alignment.center,
                  child: editMode
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            child: Text(AppLocalizations.of(context)!.save,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return StatefulBuilder(
                                        builder: ((BuildContext context,
                                            StateSetter setState) {
                                          return AlertDialog(
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .saveInformation),
                                            content: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .wantToSaveInformation,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      OutlinedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .cancel,
                                                          )),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      OutlinedButton(
                                                        onPressed: () async {
                                                          context
                                                              .read<
                                                                  AuthenticationBloc>()
                                                              .add(UpdateDataUser(
                                                                  _userEntity));
                                                          setState(() {
                                                            editMode = false;
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .confirm,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    }));
                              } else {}
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: InkWell(
                            child: Text(AppLocalizations.of(context)!.edit,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                            onTap: () {
                              setState(() {
                                editMode = true;
                              });
                            },
                          ),
                        )),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Container(
                                decoration: const ShapeDecoration(
                                    shape: CircleBorder(
                                        side: BorderSide(
                                            color: Colors.white, width: 3))),
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 234, 146, 57),
                                  backgroundImage: _file == null
                                      ? (state.user!.url != ''
                                          ? NetworkImage(state.user!.url!)
                                          : const NetworkImage(
                                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/800px-User_icon_2.svg.png')
                                              as ImageProvider)
                                      : FileImage(File(_file!.path)),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 75,
                              child: InkWell(
                                  onTap: () async {
                                    final ImagePicker picked = ImagePicker();
                                    _xFile = await picked.pickImage(
                                        source: ImageSource.gallery);
                                    if (_xFile != null) {
                                      setState(() {
                                        _file = File(_xFile!.path);
                                      });
                                      var uuid = const Uuid();
                                      var nameImage = "image_${uuid.v4()}";
                                      var request = http.MultipartRequest(
                                          "POST",
                                          Uri.parse(
                                              '${ApiConstant.baseUrl}/upload/'));
                                      request.files.add(
                                        await http.MultipartFile.fromPath(
                                            filename: nameImage,
                                            "files",
                                            _file!.path,
                                            contentType:
                                                MediaType('image', 'jpg')),
                                      );
                                      await request.send().then((response) {
                                        if (response.statusCode == 200)
                                          print("Uploaded!");
                                        print(response.statusCode);
                                        print(response.request);
                                      }).catchError((e) => print(e));

                                      context.read<AuthenticationBloc>().add(
                                          await UpdateAvataUser(nameImage));
                                    }
                                  },
                                  child: Container(
                                    decoration: const ShapeDecoration(
                                        shape: CircleBorder(),
                                        color: Colors.brown),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.name),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 150,
                              height: 60,
                              child: TextFormField(
                                onChanged: (text) {
                                  _userEntity.firstName = text;
                                },
                                initialValue: state.user?.firstName ?? "",
                                enabled: editMode ? true : false,
                                validator: (text) => text == ""
                                    ? AppLocalizations.of(context)!.noEmpty
                                    : null,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!
                                .lastNameCushionName),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 150,
                              height: 60,
                              child: TextFormField(
                                onChanged: (text) {
                                  _userEntity.lastName = text;
                                },
                                initialValue: state.user?.lastName ?? "",
                                enabled: editMode ? true : false,
                                validator: (text) => text == ""
                                    ? AppLocalizations.of(context)!.noEmpty
                                    : null,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.email),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: TextFormField(
                            initialValue: state.user?.email ?? "",
                            validator: (text) => text == ""
                                ? AppLocalizations.of(context)!.noEmpty
                                : null,
                            enabled: (state.user?.email == null && editMode)
                                ? true
                                : false,
                            onChanged: (text) {
                              _userEntity.email = text;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.phoneNumber),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: TextFormField(
                            initialValue: state.user?.phoneNumber,
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.address),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: TextFormField(
                            initialValue: state.user?.address ?? "",
                            enabled: editMode ? true : false,
                            validator: (text) => text == ""
                                ? AppLocalizations.of(context)!.noEmpty
                                : null,
                            onChanged: (text) {
                              _userEntity.address = text;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
