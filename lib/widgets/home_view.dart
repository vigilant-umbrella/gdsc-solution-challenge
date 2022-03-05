import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/user_provider.dart';
import 'package:gdsc_solution_challenge/widgets/user_info_home_page.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        backgroundColor: Colors.white,
        onRefresh: () => context.read<Users>().fetchAndSetUser(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.4,
                  child: Column(
                    children: const [
                      SizedBox(
                        width: double.infinity,
                        child: UserInfo(),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        GlassContainer.frostedGlass(
                          height: 160,
                          width: constraints.maxWidth * 0.45,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          borderRadius: BorderRadius.circular(20),
                          borderWidth: 2,
                          child: Container(
                            margin: const EdgeInsets.only(top: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [Text('abcd')],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.45,
                          height: 10,
                        ),
                        GlassContainer.frostedGlass(
                          height: 160,
                          width: constraints.maxWidth * 0.45,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          borderRadius: BorderRadius.circular(20),
                          borderWidth: 2,
                          child: Container(
                            margin: const EdgeInsets.only(top: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [Text('abcd')],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    GlassContainer.frostedGlass(
                      height: 320,
                      width: constraints.maxWidth * 0.45,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      borderRadius: BorderRadius.circular(20),
                      borderWidth: 2,
                      child: Container(
                        margin: const EdgeInsets.only(top: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [Text('abcd')],
                        ),
                      ),
                      // ),
                    ),
                  ],
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.45,
                  height: 10,
                ),
                GlassContainer.frostedGlass(
                  height: 160,
                  width: constraints.maxWidth * 0.9,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  borderRadius: BorderRadius.circular(20),
                  borderWidth: 2,
                  child: Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text('abcd')],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
