import 'package:flutter/material.dart';

class CoinButton extends StatelessWidget {
  const CoinButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          width: 106,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFED8600),
                Color(0xFFFFD52B),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 3),
                blurRadius: 4,
              ),
            ],
          ),
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF853201),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                Text(
                  '100',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'GROBOLD',
                    fontWeight: FontWeight.w600,
                    shadows: const [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
                 SizedBox(width: 10),
                GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                      color: Color(0xFF65C63A), // green
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
                SizedBox(width: 4),
              ],
            ),
          ),
        ),
        Positioned(
            left: 0,
            child: Image.asset(
              'packages/adrevauth/images/coin.png',
              height: 37,
              width: 46,
            ))
      ],
    );
  }
}
