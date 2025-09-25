import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:constitution_app/game/samvidhan_showdown.dart';
import 'package:constitution_app/screens/about_screen.dart';

void main() {
  runApp(const ConstitutionGameApp());
}

class ConstitutionGameApp extends StatelessWidget {
  const ConstitutionGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData base = ThemeData.light();
    return MaterialApp(
      title: 'Constitution Game',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        colorScheme: base.colorScheme.copyWith(
          primary: const Color(0xFF154273), // deep blue
          secondary: const Color(0xFFFF8A65), // coral
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTextTheme(base.textTheme),
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onStartGame: () => setState(() => _index = 1)),
      const GamesScreen(),
      const DailyRightScreen(),
      const ExploreScreen()
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyIndianConstitution'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF154273),
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF154273),
        ),
      ),
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: const Color(0xFF154273),
        unselectedItemColor: Colors.grey[500],
        showUnselectedLabels: true,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports_outlined), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: 'Daily'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Explore'),
        ],
      ),
    );
  }
}

/// ------------------- Home Screen -------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onStartGame});

  final VoidCallback? onStartGame;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Big banner card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              color: const Color(0xFFF1F8FF),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Learn the Indian\nConstitution in a\nFun Way!',
                            style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF15394B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.account_balance,
                      size: 48,
                      color: Colors.blueGrey[200],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            // Start and Explore buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStartGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8A65),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Start Game', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Explore Constitution')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: BorderSide(color: Colors.blueGrey.shade100),
                ),
                child: Text('Explore Constitution', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF154273))),
              ),
            ),
            const SizedBox(height: 18),
            // Small feature cards / quick actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SmallQuickCard(icon: Icons.menu_book_outlined, label: 'Articles'),
                _SmallQuickCard(icon: Icons.gavel_outlined, label: 'Amendments'),
                _SmallQuickCard(
                  icon: Icons.info_outline,
                  label: 'About',
                  onTap: () {
                    debugPrint('About tapped');
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()));
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Knowledge meter (mock)
            Text('Your Knowledge', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.42,
              backgroundColor: Colors.grey[200],
              color: const Color(0xFF154273),
              minHeight: 10,
            ),
            const SizedBox(height: 6),
            Text('42% complete', style: GoogleFonts.inter(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}

class _SmallQuickCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _SmallQuickCard({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Column(
              children: [
                Icon(icon, size: 28, color: const Color(0xFF154273)),
                const SizedBox(height: 8),
                Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ------------------- Games Screen -------------------
class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  final List<Map<String, dynamic>> games = const [
    {'title': 'Samvidhan Showdown', 'subtitle': '(Quiz)', 'icon': Icons.question_mark},
    {'title': 'Legal Blocks Mario', 'subtitle': '', 'icon': Icons.auto_awesome},
    {'title': 'Constitution Roulette', 'subtitle': '', 'icon': Icons.casino},
    {'title': 'Constitutional Ludo', 'subtitle': '', 'icon': Icons.circle},
    {'title': 'Detective Mode', 'subtitle': '', 'icon': Icons.search},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: games.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final g = games[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey.shade50,
                child: Icon(g['icon'], color: const Color(0xFF154273)),
              ),
              title: Text(g['title'], style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
              subtitle: g['subtitle'] != null && g['subtitle'] != '' ? Text(g['subtitle'], style: GoogleFonts.inter()) : null,
              trailing: ElevatedButton(
                onPressed: () {
                  if (g['title'] == 'Samvidhan Showdown') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SamvidhanShowdown()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Play: ${g['title']}')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF154273),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Play'),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ------------------- Daily Right Screen -------------------
class DailyRightScreen extends StatelessWidget {
  const DailyRightScreen({super.key});

  final String article = 'Right to Freedom of Speech (Article 19)';
  final String body =
      'You have the right to express your opinions and ideas without government interference, subject to reasonable restrictions in the interest of public order, security, and decency.';

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMMd().format(DateTime.now());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Your Constitutional Right of the Day', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: const Color(0xFF154273))),
            const SizedBox(height: 6),
            Text(date, style: GoogleFonts.inter(color: Colors.grey[600])),
            const SizedBox(height: 18),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // icons row
                    Row(
                      children: [
                        Icon(Icons.description_outlined, color: Colors.blueGrey),
                        const SizedBox(width: 12),
                        Icon(Icons.balance, color: Colors.blueGrey),
                        const SizedBox(width: 12),
                        Icon(Icons.chat_bubble_outline, color: Colors.blueGrey),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(article, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: const Color(0xFF15394B))),
                    const SizedBox(height: 12),
                    Text(body, style: GoogleFonts.inter(fontSize: 15, color: Colors.grey[800])),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            Share.share('$article\n\n$body');
                          },
                          icon: const Icon(Icons.share_outlined),
                          label: const Text('Share'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bookmarked')));
                          },
                          icon: const Icon(Icons.bookmark_add_outlined),
                          label: const Text('Bookmark'),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF154273)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------- Explore Screen -------------------
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  final List<Map<String, dynamic>> sections = const [
    {'title': 'Preamble', 'icon': Icons.flag},
    {'title': 'Fundamental Rights', 'icon': Icons.gavel},
    {'title': 'Directive Principles', 'icon': Icons.lightbulb_outline},
    {'title': 'Fundamental Duties', 'icon': Icons.rule_folder},
    {'title': 'Amendments', 'icon': Icons.history_toggle_off},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final s = sections[i];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.blueGrey.shade50, child: Icon(s['icon'], color: const Color(0xFF154273))),
              title: Text(s['title'], style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Open ${s['title']}')));
              },
            ),
          );
        },
      ),
    );
  }
}
