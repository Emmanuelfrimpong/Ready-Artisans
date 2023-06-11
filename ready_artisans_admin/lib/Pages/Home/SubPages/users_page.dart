
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_table/responsive_table.dart';
import '../../../Components/custom_button.dart';
import '../../../Components/custom_input.dart';
import '../../../State_Management/data_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/styles.dart';

class UsersPage extends ConsumerStatefulWidget {
  const UsersPage({super.key});

  @override
  ConsumerState<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends ConsumerState<UsersPage> {
  @override
  void initState() {
    _mockPullData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int total = ref.watch(filterUserMap).length;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: size.width,
            height: size.width > 800 ? 100 : 30,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(children: [
              if (size.width <= 800)
                Text(
                  'Home/Users',
                  style: GoogleFonts.nunito(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                ),
              if (size.width > 800)
                Image.asset(
                  'assets/images/logo_h_t.png',
                ),
              const SizedBox(
                width: 50,
              ),
              const Spacer(),
              if (size.width > 800)
                Text(
                  'Home/Users',
                  style: GoogleFonts.nunito(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                )
            ]),
          ),
          const SizedBox(height: 20),
          ResponsiveDatatable(
            autoHeight: false,
            title: Text(
              "Users",
              style: getCustomTextStyle(context,
                  fontWeight: FontWeight.bold, fontSize: 32),
            ),
            onTabRow: (data) {},
            actions: [
              const Spacer(),
              //create search bar if isSearching is true
              if (isSearching || size.width > 900)
                SizedBox(
                  width: size.width > 900 ? 700 : 430,
                  child: CustomTextFields(
                    hintText: "Search user",
                    onChanged: (value) {
                      ref.read(queryStringProvider.notifier).state = value;
                      _resetData(data: ref.watch(filterUserMap));
                    },
                  ),
                ),
              if (size.width < 900)
                IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = !isSearching;
                      });
                    },
                    icon: Icon(
                      isSearching ? Icons.close : Icons.search,
                      color: primaryColor,
                    )),
              const SizedBox(
                width: 10,
              ),

            ],
            headerTextStyle: getCustomTextStyle(context,
                fontSize: 16, fontWeight: FontWeight.w600),
            reponseScreenSizes: const [
              ScreenSize.xs,
              ScreenSize.sm,
              //ScreenSize.md,
              // ScreenSize.lg
            ],
            source: _source,
            isLoading: _isLoading,
            selecteds: const [],
            expanded: const [false],
            footers: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: const Text("Rows per page:"),
              ),
              if (_perPages.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButton<int>(
                    value: _currentPerPage,
                    items: _perPages
                        .map((e) => DropdownMenuItem<int>(
                      value: e,
                      child: Text("$e"),
                    ))
                        .toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        _currentPerPage = value;
                        _currentPage = 1;
                        _resetData(data: ref.watch(filterUserMap));
                      });
                    },
                    isExpanded: false,
                  ),
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                    "$_currentPage - ${_currentPerPage! + _currentPage - 1} of $total"),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                ),
                onPressed: _currentPage == 1
                    ? null
                    : () {
                  var nextSet0 = _currentPage - _currentPerPage!;
                  setState(() {
                    _currentPage = nextSet0 > 1 ? nextSet0 : 1;
                    _resetData(
                        start: _currentPage - 1,
                        data: ref.watch(filterUserMap));
                  });
                },
                padding: const EdgeInsets.symmetric(horizontal: 15),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
                onPressed: _currentPage + _currentPerPage! - 1 >= total
                    ? null
                    : () {
                  var nextSet = _currentPage + _currentPerPage!;

                  setState(() {
                    _currentPage =
                    nextSet < total ? nextSet : total - _currentPerPage!;
                    _resetData(
                        start: nextSet - 1,
                        data: ref.watch(filterUserMap));
                  });
                },
                padding: const EdgeInsets.symmetric(horizontal: 15),
              )
            ],
            headers: [
              DatatableHeader(
                text: "Image",
                value: "image",
                show: true,
                sortable: false,
                textAlign: TextAlign.center,
                sourceBuilder: (value, row) {
                  if (value != null) {
                    return Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(value), fit: BoxFit.contain)),
                    );
                  } else {
                    return Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/user.png'),
                              fit: BoxFit.contain)),
                    );
                  }
                },
              ),
              DatatableHeader(
                  text: "ID",
                  value: "id",
                  show: true,
                  sortable: true,
                  textAlign: TextAlign.center),
              DatatableHeader(
                  text: "Name",
                  value: "fullName",
                  show: true,
                  sortable: true,
                  textAlign: TextAlign.start),
              DatatableHeader(
                  text: "Phone",
                  value: "telephone",
                  show: true,
                  sortable: true,
                  textAlign: TextAlign.center),
              DatatableHeader(
                  text: "Role",
                  value: "role",
                  show: true,
                  sortable: true,
                  textAlign: TextAlign.center),
              DatatableHeader(
                  text: "Status",
                  value: "status",
                  show: true,
                  sortable: true,
                  textAlign: TextAlign.center,
                  sourceBuilder: (value, row) {
                    return Text(
                      value.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          color: value == "active".toLowerCase()
                              ? Colors.green
                              : Colors.redAccent),
                    );
                  }),
              DatatableHeader(
                  text: "Last Login",
                  value: "lastLogin",
                  show: true,
                  sortable: true,
                  textAlign: TextAlign.center,
                  sourceBuilder: (value, row) {
                    return Text(
                      value ?? "Never",
                      textAlign: TextAlign.center,
                    );
                  }),
              DatatableHeader(
                  text: "Action",
                  value: "id",
                  show: true,
                  sortable: false,
                  textAlign: TextAlign.center,
                  sourceBuilder: (value, row) {
                    var userState = row['status'];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(userState == "active")
                          Tooltip(
                            message: 'Disable User',
                            child: IconButton(
                              icon: const Icon(Icons.disabled_by_default, color: primaryColor),
                              onPressed: () {

                              },
                            ),
                          ),
                        if(userState == "Disabled"|| userState == "Pending")
                          Tooltip(
                            message: 'Enable User',
                            child: IconButton(
                              icon: const Icon(Icons.check_circle, color: primaryColor),
                              onPressed: () {

                              },
                            ),
                          ),
                        const SizedBox(
                          width: 25,
                        )
                      ],
                    );
                  }),
            ],
          )
        ]),
      ),
    );
  }
  final List<int> _perPages = [10, 20, 50, 100];
  int? _currentPerPage = 10;
  int _currentPage = 1;
  List<Map<String, dynamic>> _source = [];
  bool _isLoading = true;
  bool isSearching = false;
  _resetData({start = 0, List<Map<String, dynamic>>? data}) async {
    setState(() => _isLoading = true);
    var expandedLen = data!.length - start < _currentPerPage!
        ? data.length - start
        : _currentPerPage;
    _source.clear();
    _source = data.getRange(start, start + expandedLen).toList();
    setState(() => _isLoading = false);
  }

    _mockPullData() {
    final mockData = ref.watch(usersStreamProvider);
    mockData.whenData((data) {
      ref.watch(usersProvider.notifier).state=data;
      ref.refresh(filterUserMap);
    });

      var data = ref.watch(filterUserMap);
      setState(() => _isLoading = true);
      _source = data.length >= _currentPerPage!
          ?data
          .getRange(0, _currentPerPage!)
          .toList()
          : data.toList();
      setState(() => _isLoading = false);
    }


}
