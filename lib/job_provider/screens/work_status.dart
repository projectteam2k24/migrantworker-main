import 'package:flutter/material.dart';

class WorkingStatusPage extends StatefulWidget {
  const WorkingStatusPage({super.key});

  @override
  _WorkingStatusPageState createState() => _WorkingStatusPageState();
}

class _WorkingStatusPageState extends State<WorkingStatusPage> {
  final List<Map<String, dynamic>> jobList = [
    {
      'jobTitle': 'Painting - Residential',
      'contractorName': 'John Doe Constructions',
      'startDate': '01/11/2024',
      'endDate': '10/11/2024',
      'status': 'In Progress',
      'progress': 1.0,
    },
    {
      'jobTitle': 'Electrical Wiring',
      'contractorName': 'Elite Electricians',
      'startDate': '05/11/2024',
      'endDate': '20/11/2024',
      'status': 'Completed',
      'progress': 1.0,
    },
    {
      'jobTitle': 'Flooring Installation',
      'contractorName': 'Modern Builders',
      'startDate': '10/11/2024',
      'endDate': '25/11/2024',
      'status': 'Not Started',
      'progress': 0.0,
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter jobs based on the search query
    final filteredJobs = jobList.where((job) {
      final jobTitle = job['jobTitle'].toString().toLowerCase();
      return jobTitle.contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Working Status'),
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
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green, width: 1.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value; // Update the search query
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search by Job Title...',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Optionally handle search button tap
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Job Cards
            Expanded(
              child: filteredJobs.isEmpty
                  ? const Center(
                      child: Text(
                        'No jobs found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredJobs.length,
                      itemBuilder: (context, index) {
                        final job = filteredJobs[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job['jobTitle'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.business,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Contractor: ${job['contractorName']}',
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Start: ${job['startDate']}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      'End: ${job['endDate']}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.info,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Status: ${job['status']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: job['progress'] >= 0.85
                                            ? Colors.green
                                            : job['progress'] >= 0.25
                                                ? Colors.orange
                                                : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                LinearProgressIndicator(
                                  value: job['progress'],
                                  backgroundColor: Colors.grey[300],
                                  color: job['progress'] >= 0.85
                                      ? Colors.green
                                      : job['progress'] >= 0.25
                                          ? Colors.orange
                                          : Colors.red,
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${(job['progress'] * 100).toInt()}% Completed',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
