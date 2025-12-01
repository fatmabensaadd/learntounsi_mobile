import 'package:flutter/material.dart';
import '../viewmodels/quizVM.dart';

class QuizPage extends StatefulWidget {
  final String matiere;
  final String cours;

  const QuizPage({required this.matiere, required this.cours, super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final vm = QuizViewModel();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  Future<void> loadQuiz() async {
    await vm.loadQuiz(widget.matiere, widget.cours);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFC2A83E),
          ),
        ),
      );
    }

    // Aucun quiz trouvé
    if (vm.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Quiz"),
          backgroundColor: Color(0xFF234138),
        ),
        body: Center(
          child: Text(
            "Aucun quiz disponible pour ce cours.",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    final question = vm.questions[vm.index];

    // Page Résultat
    if (vm.finished) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Résultat"),
          backgroundColor: Color(0xFF234138),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF234138), Color(0xFFC5E782)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Score : ${vm.score} / ${vm.questions.length}",
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC2A83E),
                  padding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 26),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Retour",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      );
    }

    // PAGE QUIZ
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.cours} — Question ${vm.index + 1}/${vm.questions.length}",
        ),
        backgroundColor: const Color(0xFF234138),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF234138), Color(0xFFC5E782), Color(0xFFD9C46F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // ======= QUESTION CARD =======
            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Text(
                question["question"],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1e332e),
                ),
              ),
            ),

            // ======= OPTIONS =======
            Expanded(
              child: ListView.builder(
                itemCount: question["options"].length,
                itemBuilder: (context, i) {
                  final selected = vm.answers[vm.index] == i;

                  return GestureDetector(
                    onTap: () {
                      setState(() => vm.selectAnswer(vm.index, i));
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected
                              ? Colors.transparent
                              : const Color(0xFFE4E4E4),
                          width: 2,
                        ),
                        gradient: selected
                            ? const LinearGradient(
                          colors: [
                            Color(0xFFC2A83E),
                            Color(0xFF7CA982)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                            : null,
                        color: selected ? null : Colors.white,
                        boxShadow: selected
                            ? [
                          const BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ]
                            : [],
                      ),
                      child: Text(
                        question["options"][i],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: selected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ======= NAVIGATION BUTTONS =======
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // -------- PREVIOUS --------
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF234138),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(
                        color: Color(0xFF234138),
                        width: 2,
                      ),
                    ),
                  ),
                  onPressed: vm.index == 0
                      ? null
                      : () {
                    setState(vm.prev);
                  },
                  child: const Text(
                    "Précédent",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // -------- NEXT or FINISH --------
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC2A83E),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    setState(vm.index < vm.questions.length - 1
                        ? vm.next
                        : vm.finish);
                  },
                  child: Text(
                    vm.index < vm.questions.length - 1
                        ? "Suivant"
                        : "Terminer",
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
