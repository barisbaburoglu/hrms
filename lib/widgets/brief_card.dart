import 'package:flutter/material.dart';

class BriefCard extends StatelessWidget {
  final Color backgroundColor;
  final Widget icon;
  final String title;
  final String value;
  final Function()? onTap;

  const BriefCard({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor:
          onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onTap: onTap,
      child: Container(
        height: 120,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Sol taraf (Metinler)
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Detaylar için tıklayınız",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Sağ taraf (İkon)
            Flexible(
              flex: 1,
              child: SizedBox.expand(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  child: icon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
