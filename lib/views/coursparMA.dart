import 'package:flutter/material.dart';
import 'package:learntounsi_mobile/views/page_cours.dart';
import 'package:learntounsi_mobile/views/terminer.dart';
import 'package:provider/provider.dart';
import '../viewmodels/courparM.dart';

class CoursParMatierePage extends StatelessWidget {
  final String matiere;

  CoursParMatierePage({required this.matiere});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CoursParMatiereVM>(context);

    // Charger les cours automatiquement
    if (vm.courses.isEmpty && vm.loading == false) {
      vm.loadCourses(matiere);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Cours : $matiere"),
        backgroundColor: Color(0xFF234138),
      ),

      body: vm.loading
          ? Center(
        child: CircularProgressIndicator(color: Color(0xFFC5E782)),
      )
          : vm.courses.isEmpty
          ? Center(
        child: Text(
          "📚 Aucun cours trouvé",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: vm.courses.length,
        itemBuilder: (ctx, i) {
          final c = vm.courses[i];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            elevation: 6,
            shadowColor: Colors.black26,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    "assets/images/${c.image}",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.titre,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF234138),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        c.description,
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC2A83E),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PageCours(
                                matiere: matiere,
                                cours: c.titre,   // 🔥 ENVOI DU TITRE EXACT
                              ),
                            ),
                          );
                        },
                        child: Text("Commencer", style: TextStyle(color: Colors.white)),
                      )

                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
