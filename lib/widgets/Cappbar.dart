import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../views/profile.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return AppBar(
      elevation: 4,
      backgroundColor: const Color(0xFF234138),

      title: const Text(
        "LearnTounsi",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      actions: [
        // Affichage email utilisateur si connecté
        if (authVM.user != null)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                authVM.user!.email!,
                style: const TextStyle(
                  color: Color(0xFFC5E782),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

        // Bouton profil (optionnel)
        if (authVM.user != null)
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),

        // Bouton Menu / Drawer
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ],
    );
  }
}
