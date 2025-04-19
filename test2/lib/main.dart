import 'package:flutter/material.dart';

class Employee {
  final String name;
  final String department;
  final String jobTitle;
  final String startDate;
  final String category;
  final String gender;

  Employee({
    required this.name,
    required this.department,
    required this.jobTitle,
    required this.startDate,
    required this.category,
    required this.gender,
  });
}

class EmployeeDashboard extends StatelessWidget {
  final List<Employee> employees = [
    Employee(
      name: 'yesoline duclee',
      department: 'Design',
      jobTitle: 'UI UX Designer',
      startDate: '28/04/2022',
      category: 'Full time',
      gender: 'Female',
    ),
    Employee(
      name: 'feven tesfaye',
      department: 'IT',
      jobTitle: 'Backend Engineer',
      startDate: '28/04/2022',
      category: 'Remote',
      gender: 'Female',
    ),
    // Add other employees here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: const Color(0xFF1A237E),
            child: Column(
              children: [
                // Logo and Admin info
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Image.asset('assets/logo.png', height: 40),
                      const SizedBox(height: 16),
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.orange,
                        child: Icon(Icons.person, color: Colors.white, size: 30),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Aman Admin',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Menu items
                _buildMenuItem(Icons.dashboard, 'Dashboard'),
                _buildMenuItem(Icons.message, 'Messages', hasNotification: true),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Recruitment',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                _buildMenuItem(Icons.work, 'Jobs'),
                _buildMenuItem(Icons.people, 'Candidates'),
                _buildMenuItem(Icons.description, 'Resumes'),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Organization',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                _buildMenuItem(Icons.people_outline, 'Employee Management', 
                    isSelected: true),
                _buildMenuItem(Icons.group_work, 'Leave Management'),
                _buildMenuItem(Icons.assessment, 'Performance Management'),
                _buildMenuItem(Icons.payment, 'Payroll Management'),
                const Spacer(),
                _buildMenuItem(Icons.exit_to_app, 'Log Out', 
                    color: Colors.red),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Container(
              color: const Color(0xFFF5F7FA),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      const Text(
                        'Dashboard / Employee Management',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.notifications),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.flash_on),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.email),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Employee Management header
                  Row(
                    children: [
                      const Text(
                        'Employee Management',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {},
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.file_download),
                        label: const Text('Export'),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Table
                  Expanded(
                    child: Card(
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Name(s)')),
                            DataColumn(label: Text('Dept')),
                            DataColumn(label: Text('Job Title')),
                            DataColumn(label: Text('Start Date')),
                            DataColumn(label: Text('Category')),
                            DataColumn(label: Text('Gender')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: employees.map((employee) => DataRow(
                            cells: [
                              DataCell(Text(employee.name)),
                              DataCell(Text(employee.department)),
                              DataCell(Text(employee.jobTitle)),
                              DataCell(Text(employee.startDate)),
                              DataCell(Text(employee.category)),
                              DataCell(Text(employee.gender)),
                              DataCell(PopupMenuButton(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    child: Text('View Profile'),
                                  ),
                                  const PopupMenuItem(
                                    child: Text('Edit Profile'),
                                  ),
                                ],
                              )),
                            ],
                          )).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {
    bool isSelected = false,
    bool hasNotification = false,
    Color color = Colors.white,
  }) {
    return Container(
      color: isSelected ? Colors.white.withOpacity(0.1) : null,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(color: color),
        ),
        trailing: hasNotification
            ? Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '1',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            : null,
        onTap: () {},
      ),
    );
  }
}