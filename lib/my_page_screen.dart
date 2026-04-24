import 'package:flutter/material.dart';
import 'package:jibbab_app/discount_screen.dart'; // 데이터 연동을 위해 임포트
import 'package:jibbab_app/recipe_screen.dart';   // 화면 이동을 위해 임포트

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  // 🌟 활동 요약 데이터 (실제 데이터 연동)
  // 'seona'가 등록한 할인정보 개수 계산
  int get _myDiscountCount => globalDiscounts.where((d) => d['author'] == 'seona').length;

  // 맛있었어요 및 저장 레시피 (현재는 가상 데이터, 추후 기능 확장 가능)
  final int _myLikesCount = 28;
  final int _mySavedRecipesCount = 12;

  // 🌟 공지사항 다이얼로그 함수
  void _showNoticeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('공지사항', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
          '집밥의민족 v1.0.0 출시! 🎉\n앞으로 더 많은 레시피와 할인정보를 업데이트할 예정입니다.',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인', style: TextStyle(color: Color(0xFF1D9E75))),
          ),
        ],
      ),
    );
  }

  // 🌟 앱 정보 다이얼로그 함수
  void _showAppInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('앱 정보', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('앱 이름: 집밥의민족', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('버전: v1.0.0'),
            SizedBox(height: 8),
            Text('슬로건: 해먹자, 근데 싸게 🏠'),
            Divider(),
            Text('개발자: 안선아 (Seona-An)'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인', style: TextStyle(color: Color(0xFF1D9E75))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1D9E75);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '마이페이지',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 프로필 영역
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: primaryColor,
                    child: Text('S', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('seona', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('해먹는 즐거움을 아는 자취생', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),

            // 활동 요약 카드 (실제 데이터 반영)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActivityItem('등록 할인', _myDiscountCount.toString()),
                  _buildActivityItem('맛있었어요', _myLikesCount.toString()),
                  _buildActivityItem('저장 레시피', _mySavedRecipesCount.toString()),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Divider(thickness: 8, color: Color(0xFFF5F5F5)),

            // 메뉴 리스트
            _buildMenuItem(
              icon: Icons.list_alt,
              title: '내가 등록한 할인정보',
              onTap: () {
                // 할인정보 탭은 같은 메인 화면에 있으므로,
                // 여기서는 새로운 페이지로 띄우거나 탭 인덱스를 바꿔야 합니다.
                // 미니 프로젝트에서는 직관적으로 해당 화면을 push합니다.
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DiscountScreen()));
              },
            ),
            _buildMenuItem(
              icon: Icons.bookmark_outline,
              title: '저장한 레시피',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RecipeScreen()));
              },
            ),
            _buildMenuItem(
              icon: Icons.notifications_none,
              title: '공지사항',
              onTap: _showNoticeDialog, // 🌟 공지사항 다이얼로그 호출
            ),
            _buildMenuItem(
              icon: Icons.info_outline,
              title: '앱 정보',
              trailing: 'v 1.0.0',
              onTap: _showAppInfoDialog, // 🌟 앱 정보 다이얼로그 호출
            ),

            const SizedBox(height: 40),
            const Text('집밥의민족 — 해먹자, 근데 싸게 🏠', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String label, String count) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1D9E75))),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
      ],
    );
  }

  Widget _buildMenuItem({required IconData icon, required String title, String? trailing, required VoidCallback onTap}) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF5F5F5)))),
      child: ListTile(
        leading: Icon(icon, color: Colors.black87, size: 22),
        title: Text(title, style: const TextStyle(fontSize: 15)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailing != null) Text(trailing, style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}