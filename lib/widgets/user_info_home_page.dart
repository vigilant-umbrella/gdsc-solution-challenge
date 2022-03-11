import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<Users>().fetchAndSetUser(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            child: Center(child: CircularProgressIndicator()),
            // trying fixing layout shifting issue
            height: 195,
          );
        }
        if (dataSnapshot.error != null) {
          return const Center(child: Text('An error occurred!'));
        }
        return Consumer<Users>(
          builder: (_, userData, _child) => Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              userData.user.image,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        userData.user.userName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    userData.user.points.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      letterSpacing: 3,
                    ),
                  ),
                  const Text(
                    'points',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
