import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/circular.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final List<Circular> circulars = [
    Circular(
      title: 'Monthly Team Meeting',
      description: 'Discussion about Q1 goals and achievements',
      category: 'Meeting',
      date: '2024-02-25',
      author: 'John Doe',
      status: 'Active',
    ),
    Circular(
      title: 'New Policy Update',
      description: 'Important changes to company policies',
      category: 'Policy',
      date: '2024-02-24',
      author: 'HR Department',
      status: 'Active',
    ),
    Circular(
      title: 'Office Maintenance',
      description: 'Scheduled maintenance work',
      category: 'Announcement',
      date: '2024-02-23',
      author: 'Facility Team',
      status: 'Completed',
    ),
  ];

  int currentPage = 1;
  final int itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(kDefaultPadding),
            itemCount: circulars.length,
            itemBuilder: (context, index) {
              final circular = circulars[index];
              return Card(
                margin: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              circular.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: circular.status == 'Active'
                                  ? kPrimaryColor.withOpacity(0.2)
                                  : Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              circular.status,
                              style: TextStyle(
                                color: circular.status == 'Active'
                                    ? kPrimaryColor
                                    : Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        circular.description,
                        style: const TextStyle(
                          color: kTextColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            circular.category,
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            circular.date,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'By ${circular.author}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: currentPage > 1
                    ? () {
                        setState(() {
                          currentPage--;
                        });
                      }
                    : null,
              ),
              const SizedBox(width: 10),
              Text(
                'Page $currentPage',
                style: const TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: circulars.length >= itemsPerPage
                    ? () {
                        setState(() {
                          currentPage++;
                        });
                      }
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
