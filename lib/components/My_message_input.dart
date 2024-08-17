import 'package:flutter/material.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SearchSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 140, 198, 64),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  //Arrondir les bords
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: "entrer votre message...",
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                hintStyle: const TextStyle(
                  textBaseline: TextBaseline.alphabetic,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 140, 198, 64),
              ),
              child: const Icon(
                Icons.mic_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    ); //des fonctionnalites de design avancé
  }
}
