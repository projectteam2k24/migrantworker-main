import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProviderJobsPage extends StatelessWidget {
  const ProviderJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for jobs posted by the provider
    final List<Map<String, dynamic>> providerJobList = [
      {
        'jobTitle': 'Kitchen Renovation',
        'address': '123 Main Street, Downtown City',
        'location': 'Downtown City',
        'squareFeet': '500 sqft',
        'budget': '\$15,000',
        'images': [
          'assets/image1.jpg',
          'assets/image2.jpg',
          'assets/image3.jpg',
        ],
      },
      {
        'jobTitle': 'Bathroom Remodeling',
        'address': '456 Elm Street, Riverside',
        'location': 'Riverside Apartments',
        'squareFeet': '300 sqft',
        'budget': '\$8,000',
        'images': [
          'assets/image1.jpg',
          'assets/image2.jpg',
          'assets/image3.jpg',
        ],
      },
      {
        'jobTitle': 'Roof Repair',
        'address': '789 Pine Street, Hilltop',
        'location': 'Hilltop Villas',
        'squareFeet': '700 sqft',
        'budget': '\$5,000',
        'images': [
          'assets/image1.jpg',
          'assets/image2.jpg',
          'assets/image3.jpg',
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Jobs'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: providerJobList.length,
          itemBuilder: (context, index) {
            final job = providerJobList[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Slider
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                        ),
                        items: job['images'].map<Widget>((imageUrl) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  size: 100,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Job Title
                            Text(
                              job['jobTitle'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Address
                            Row(
                              children: [
                                const Icon(Icons.home,
                                    size: 16, color: Colors.grey),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    job['address'],
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Location
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 16, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text(
                                  'Location: ${job['location']}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Square Feet
                            Row(
                              children: [
                                const Icon(Icons.square_foot,
                                    size: 16, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text(
                                  'Size: ${job['squareFeet']}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Budget
                            Row(
                              children: [
                                const Icon(Icons.attach_money,
                                    size: 16, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text(
                                  'Budget: ${job['budget']}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Positioned "View in Detail" button at the bottom-right
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to detailed job view (add the navigation logic here)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetailPage(job: job),
                          ),
                        );
                      },
                      child: const Text(
                        'View in Detail',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


class JobDetailPage extends StatelessWidget {
  final Map<String, dynamic> job;

  const JobDetailPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job['jobTitle']),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Title
            Text(
              job['jobTitle'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            // Image Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
              ),
              items: job['images'].map<Widget>((imageUrl) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey,
                      );
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Job Description Container with Shadow
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7), // Light white background with slight opacity
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12, // Subtle shadow
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Job Description Title
                  Text(
                    'Job Description:',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Job Description Text
                  Text(
                    'Looking for a skilled professional for a kitchen renovation project. Tasks include replacing countertops, cabinets, flooring, and lighting, as well as installing new appliances. The job requires expertise in design, plumbing, and electrical work. Ideal candidates should have experience in creating functional, modern, and stylish kitchen spaces.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Address
            Row(
              children: [
                const Icon(Icons.home, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(job['address'], style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            // Location
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Location: ${job['location']}',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            // Square Feet
            Row(
              children: [
                const Icon(Icons.square_foot, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Size: ${job['squareFeet']}',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            // Budget
            Row(
              children: [
                const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Budget: ${job['budget']}',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class JobDetailPage1 extends StatelessWidget {
  final Map<String, dynamic> job;

  const JobDetailPage1({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job['jobTitle']),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Title
            Text(
              job['jobTitle'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            // Image Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
              ),
              items: job['images'].map<Widget>((imageUrl) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey,
                      );
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Job Description Container with Shadow
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7), // Light white background with slight opacity
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12, // Subtle shadow
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Job Description Title
                  Text(
                    'Job Description:',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Job Description Text
                  Text(
                    'Seeking a professional for a bathroom remodeling project. Responsibilities include updating fixtures, replacing flooring, installing new tiles, vanities, and lighting, and improving plumbing and electrical systems. The goal is to enhance the space’s functionality, design, and efficiency while creating a modern and stylish bathroom that suits the homeowner’s needs.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Address
            Row(
              children: [
                const Icon(Icons.home, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(job['address'], style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            // Location
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Location: ${job['location']}',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            // Square Feet
            Row(
              children: [
                const Icon(Icons.square_foot, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Size: ${job['squareFeet']}',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            // Budget
            Row(
              children: [
                const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Budget: ${job['budget']}',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class JobDetailPage2 extends StatelessWidget {
  final Map<String, dynamic> job;

  const JobDetailPage2({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job['jobTitle']),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Title
            Text(
              job['jobTitle'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            // Image Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
              ),
              items: job['images'].map<Widget>((imageUrl) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey,
                      );
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Job Description Container with Shadow
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7), // Light white background with slight opacity
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12, // Subtle shadow
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Job Description Title
                  Text(
                    'Job Description:',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Job Description Text
                  Text(
                    'Looking for an experienced professional for roof repair. Tasks include identifying and fixing leaks, replacing damaged shingles, and ensuring proper insulation and ventilation. The job requires expertise in various roofing materials and techniques to restore the roof’s integrity, prevent further damage, and extend its lifespan.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Address
            Row(
              children: [
                const Icon(Icons.home, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(job['address'], style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            // Location
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Location: ${job['location']}',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            // Square Feet
            Row(
              children: [
                const Icon(Icons.square_foot, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Size: ${job['squareFeet']}',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            // Budget
            Row(
              children: [
                const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Budget: ${job['budget']}',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

