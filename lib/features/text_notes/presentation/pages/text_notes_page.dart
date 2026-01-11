import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:login_mobx/features/login/presentation/pages/login_page.dart';
import 'package:login_mobx/features/statistics/presentation/pages/statistics_page.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/widgets/privacy_policy_link.dart';
import '../../../../injection_container.dart';

import '../stores/text_notes_store.dart';

class TextNotesPage extends StatefulWidget {
  const TextNotesPage({super.key});

  @override
  State<TextNotesPage> createState() => _TextNotesPageState();
}

class _TextNotesPageState extends State<TextNotesPage> {
  final TextNotesStore store = sl<TextNotesStore>();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    store.loadNotes();

    reaction((_) => store.currentText, (text) {
      if (_textController.text != text) {
        _textController.text = text;
        _textController.selection = TextSelection.fromPosition(TextPosition(offset: _textController.text.length));
      }
    });

    _textController.addListener(() {
      store.setText(_textController.text);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1D525E), Color(0xFF43767E)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Sair',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const StatisticsPage()));
                      },
                      child: const Text(
                        'Estatisticas',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Observer(
                  builder: (_) {
                    if (store.isLoading && store.notes.isEmpty) {
                      return const Center(child: CircularProgressIndicator(color: Colors.white));
                    }

                    if (store.notes.isEmpty) {
                      return const Center(
                        child: Text('Nenhuma nota salva.', style: TextStyle(color: Colors.white, fontSize: 16)),
                      );
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        itemCount: store.notes.length,
                        itemBuilder: (context, index) {
                          final note = store.notes[index];
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      note.content,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      store.startEditing(note);
                                      _focusNode.requestFocus();
                                    },
                                    icon: const Icon(Icons.edit, color: Colors.black),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: () => store.deleteNote(note.id),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                      child: const Icon(Icons.close, color: Colors.white, size: 18),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(color: Colors.grey, thickness: 2),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                      child: TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        textAlign: TextAlign.center,
                        onSubmitted: (_) {
                          if (store.canSave) {
                            store.saveNote();
                            _focusNode.unfocus();
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Digite seu texto',
                          hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Observer(
                builder: (_) {
                  if (!store.canSave) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          store.saveNote();
                          _focusNode.unfocus();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          disabledBackgroundColor: const Color(0xFF386369).withValues(alpha: 0.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          elevation: 0,
                        ),
                        child: const Text('Salvar', style: TextStyle(color: Colors.black, fontSize: 16)),
                      ),
                    ),
                  );
                },
              ),
              const PrivacyPolicyLink(),
            ],
          ),
        ),
      ),
    );
  }
}
