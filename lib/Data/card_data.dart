import 'package:flutter/material.dart';

// Defines the data structure for a single card.
class CardItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const CardItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

// This is the list of all items that will be displayed in the GridView.
// By keeping it in a separate file, your UI code stays clean.
const List<CardItem> cardItems = [
  CardItem(
      title: "Alumni Directory",
      subtitle: "Find old friends",
      icon: Icons.search,
      color: Colors.orange),
  CardItem(
      title: "Events",
      subtitle: "Upcoming gatherings",
      icon: Icons.event,
      color: Colors.blue),
  CardItem(
      title: "Job Board",
      subtitle: "New opportunities",
      icon: Icons.work,
      color: Colors.green),
  CardItem(
      title: "News",
      subtitle: "Latest updates",
      icon: Icons.article,
      color: Colors.purple),
  CardItem(
      title: "Gallery",
      subtitle: "Event photos",
      icon: Icons.photo_album,
      color: Colors.pink),
  CardItem(
      title: "Mentorship",
      subtitle: "Connect with mentors",
      icon: Icons.school,
      color: Colors.teal),

];