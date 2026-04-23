import 'package:flutter/material.dart';
import 'package:jibbab_app/recipe_model.dart'; // 모델 임포트

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe; // 레시피 객체를 받습니다.

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late int _likesCount;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _likesCount = widget.recipe.likes; // 받은 데이터로 초기화
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _isLiked ? _likesCount++ : _likesCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1D9E75);
    final r = widget.recipe; // 사용하기 편하게 변수 지정

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(r.name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 헤더
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: [
                    Text(r.emoji, style: const TextStyle(fontSize: 80)),
                    const SizedBox(height: 16),
                    Text(r.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildBadge(r.category, Colors.grey.shade600, Colors.grey.shade100),
                        const SizedBox(width: 8),
                        _buildBadge(r.difficulty, primaryColor, primaryColor.withOpacity(0.1)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(thickness: 8, color: Color(0xFFF5F5F5)),
            // 요약 정보
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryItem(Icons.timer_outlined, r.time),
                  _buildSummaryItem(Icons.kitchen_outlined, '재료 ${r.ingredientCount}개'),
                  GestureDetector(
                    onTap: _toggleLike,
                    child: _buildSummaryItem(
                      _isLiked ? Icons.favorite : Icons.favorite_outline,
                      '$_likesCount명',
                      iconColor: _isLiked ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 8, color: Color(0xFFF5F5F5)),
            // 재료 목록
            _buildSectionTitle('재료 목록'),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFEAF3DE), borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: r.ingredients.map((ing) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(ing['name']!), Text(ing['amount']!, style: const TextStyle(color: Colors.black54))],
                  ),
                )).toList(),
              ),
            ),
            // 조리 순서
            _buildSectionTitle('조리 순서'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: List.generate(r.steps.length, (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(radius: 12, backgroundColor: primaryColor, child: Text('${i+1}', style: const TextStyle(color: Colors.white, fontSize: 12))),
                      const SizedBox(width: 12),
                      Expanded(child: Text(r.steps[i], style: const TextStyle(fontSize: 15, height: 1.4))),
                    ],
                  ),
                )),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor, padding: const EdgeInsets.symmetric(vertical: 16)),
            onPressed: () {},
            child: const Text('지금 만들기 🍳', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(children: [Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]),
    );
  }

  Widget _buildBadge(String text, Color txt, Color bg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
    child: Text(text, style: TextStyle(color: txt, fontSize: 12, fontWeight: FontWeight.bold)),
  );

  Widget _buildSummaryItem(IconData icon, String txt, {Color? iconColor}) => Column(
    children: [Icon(icon, color: iconColor ?? Colors.black54), const SizedBox(height: 4), Text(txt, style: const TextStyle(fontSize: 13))],
  );
}