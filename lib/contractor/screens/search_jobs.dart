import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyJobPageContractor extends StatefulWidget {
  const MyJobPageContractor({super.key});

  @override
  _MyJobPageContractorState createState() => _MyJobPageContractorState();
}

class _MyJobPageContractorState extends State<MyJobPageContractor> {
  final List<Map<String, dynamic>> providerJobList = [
    {
      'jobTitle': 'Kitchen Renovation',
      'address': '123 Main Street, Downtown City',
      'location': 'Downtown City',
      'squareFeet': '500 sqft',
      'budget': '\$15,000',
      'images': [
        'assets/images/image1.jpg',
        'assets/images/image2.jpg',
        'assets/images/image3.jpg',
      ],
      'description':
          'Renovation of the kitchen area to include modern appliances, countertops, and cabinets.',
      'postedDate': 'Today',
    },
    {
      'jobTitle': 'Bathroom Remodeling',
      'address': '456 Elm Street, Riverside',
      'location': 'Riverside Apartments',
      'squareFeet': '300 sqft',
      'budget': '\$8,000',
      'images': [
        'assets/images/image1.jpg',
        'assets/images/image2.jpg',
        'assets/images/image3.jpg',
      ],
      'description':
          'Complete makeover of the bathroom with new fittings, tiles, and lighting.',
      'postedDate': 'This Week',
    },
    {
      'jobTitle': 'Roof Repair',
      'address': '789 Pine Street, Hilltop',
      'location': 'Hilltop Villas',
      'squareFeet': '700 sqft',
      'budget': '\$5,000',
      'images': [
        'assets/images/image1.jpg',
        'assets/images/image2.jpg',
        'assets/images/image3.jpg',
      ],
      'description':
          'Repair and waterproofing of the roof to fix leaks and improve durability.',
      'postedDate': 'This Month',
    },
  ];

  List<Map<String, dynamic>> filteredJobList = [];
  String? selectedLocation;
  String? selectedDate;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredJobList = providerJobList; // Initially show all jobs
  }

  void filterJobs() {
    setState(() {
      filteredJobList = providerJobList.where((job) {
        final matchesSearchQuery = searchQuery.isEmpty ||
            job['jobTitle']
                .toString()
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
        final matchesLocation = selectedLocation == null ||
            job['location'] == selectedLocation;
        final matchesDate =
            selectedDate == null || job['postedDate'] == selectedDate;

        return matchesSearchQuery && matchesLocation && matchesDate;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Jobs'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                labelText: 'Search jobs by name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                searchQuery = value;
                filterJobs();
              },
            ),
            const SizedBox(height: 16),
            // Location Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Search by location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: providerJobList
                  .map((job) => job['location'])
                  .toSet()
                  .map<DropdownMenuItem<String>>((location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              value: selectedLocation,
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                  filterJobs();
                });
              },
            ),
            const SizedBox(height: 16),
            // Posted Date Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Search by posted date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: ['Today', 'Yesterday', 'This Week', 'This Month', 'This Year']
                  .map<DropdownMenuItem<String>>((date) {
                return DropdownMenuItem<String>(
                  value: date,
                  child: Text(date),
                );
              }).toList(),
              value: selectedDate,
              onChanged: (value) {
                setState(() {
                  selectedDate = value;
                  filterJobs();
                });
              },
            ),
            const SizedBox(height: 16),
            // Jobs List
            Expanded(
              child: ListView.builder(
                itemCount: filteredJobList.length,
                itemBuilder: (context, index) {
                  final job = filteredJobList[index];
                  return JobCard(job: job);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Map<String, dynamic> job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
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
                        const Icon(Icons.home, size: 16, color: Colors.grey),
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
            // Job Description
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Job Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    job['description'] ?? 'No description available.',
                    style: const TextStyle(fontSize: 14),
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
