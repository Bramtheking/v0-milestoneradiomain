import 'package:flutter/material.dart';
import '../utils/theme.dart';

class ClickToPlayInstructions extends StatefulWidget {
  const ClickToPlayInstructions({super.key});

  @override
  State<ClickToPlayInstructions> createState() => _ClickToPlayInstructionsState();
}

class _ClickToPlayInstructionsState extends State<ClickToPlayInstructions>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _dotAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _dotAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.milestoneBlue, AppTheme.milestoneCyan],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppTheme.milestoneBlue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🎧',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Click the play button below to start listening',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          
          const Text(
            'Ready to tune in? Press play and enjoy our educational programming!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          
          AnimatedBuilder(
            animation: _dotAnimation,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  final delay = index * 0.3;
                  final animationValue = (_dotAnimation.value - delay).clamp(0.0, 1.0);
                  
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    child: Transform.scale(
                      scale: 0.5 + (animationValue * 0.5),
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5 + (animationValue * 0.5)),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
