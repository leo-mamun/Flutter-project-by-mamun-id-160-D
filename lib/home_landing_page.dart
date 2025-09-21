//lib\home_landing_page.dart

import 'package:flutter/material.dart';
import 'package:authentication/pages/provider_list_page.dart';

class HomeLandingPage extends StatelessWidget {
  const HomeLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: const [
            Icon(Icons.home_repair_service_outlined, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              "ServiceHub",
              style: TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () {}, child: const Text("Sign In")),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProviderListPage()),
    );
  },
  child: const Text("Join as Provider"),
),
          )
        ],
      ),
      

      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- HERO ----------
            Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: size.height * 0.35),

              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1C62E3), Color(0xFF10A86F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Find Trusted Local Service Providers",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Connect with verified professionals for home services,\nrepairs, and maintenance. Quality work, guaranteed.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 20),

                  // ---- Search Bar ----
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "What service do you need?",
                                  icon: Icon(Icons.search)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: size.width * 0.3,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Location",
                                icon: Icon(Icons.location_on_outlined)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18)),
                        child: const Text("Find Providers"),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ---- Popular Services ----
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (var service in [
                        "Plumbing",
                        "Electrical",
                        "Cleaning",
                        "Handyman",
                        "HVAC",
                        "Painting"
                      ])
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade300)),
                          child: Text(service,
                              style: const TextStyle(color: Colors.black)),
                        )
                    ],
                  )
                ],
              ),
            ),

            // ---------- Browse Services ----------
            const SizedBox(height: 20),
            const Text("Browse Services",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text("Find the right professional for any job around your home",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 20),

            // Service Grid (simple Row + Wrap)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  serviceCard(Icons.plumbing, "Plumbing", 124),
                  serviceCard(Icons.electrical_services, "Electrical", 89),
                  serviceCard(Icons.cleaning_services, "Cleaning", 156),
                  serviceCard(Icons.handyman, "Handyman", 203),
                  serviceCard(Icons.ac_unit, "HVAC", 67),
                  serviceCard(Icons.format_paint, "Painting", 92),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Simple Service Card Widget
  Widget serviceCard(IconData icon, String title, int providers) {
    return Container(
      width: 150,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.blue),
          const SizedBox(height: 10),
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 6),
          Text("$providers providers",
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
