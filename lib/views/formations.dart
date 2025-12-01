import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../widgets/top_navbar.dart';
import 'page_cours.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'connexion.dart';
import '../widgets/Cappbar.dart';

class FormationsPage extends StatelessWidget {
  const FormationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),

      body: Column(
        children: [
          const TopNavigationBar(),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("cours")
                  .orderBy("titre")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child:
                      CircularProgressIndicator(color: Color(0xFF234138)));
                }

                final cours = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cours.length,
                  itemBuilder: (context, index) {
                    final c = cours[index];
                    final data = c.data() as Map<String, dynamic>;

                    final String titre = data["titre"] ?? "Sans titre";
                    final String description = data["description"] ?? "";
                    final String matiere = data["matiere"] ?? "";
                    final String image = data["image"] ?? "";
                    final bool payant =
                    (data["payant"] == "true" || data["payant"] == true);
                    final String prix = data["prix"] ?? "0dt";

                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 6,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      shadowColor: Colors.black26,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            child: Image.asset(
                              "assets/images/$image",
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(titre,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF234138))),
                                  const SizedBox(height: 6),
                                  Text(
                                    description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              // Bouton accéder
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFC2A83E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  final authVM = Provider.of<AuthViewModel>(
                                      context,
                                      listen: false);

                                  if (authVM.user == null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LoginPage(
                                          redirectTo: PageCours(
                                            matiere: matiere,
                                            cours: titre,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PageCours(
                                          matiere: matiere,
                                          cours: titre,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  "Accéder",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),

                              const SizedBox(height: 6),

                              // Bouton acheter si payant
                              if (payant)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Page paiement
                                  },
                                  child: Text(
                                    "Acheter ($prix)",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(width: 12),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
