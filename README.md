# Kampala Nights – Event Listing Demo App

A Flutter demo nightlife event discovery application inspired by platforms like Kampala Nights.

Built to showcase a clean mobile UI, booking flow, and scalable architecture for Android and iOS.

|||||
|---|---|---|---|
|<img width="1080" height="2220" alt="Screenshot_1777294078" src="https://github.com/user-attachments/assets/f46bb62a-708a-4da3-adf6-ea6bd27413e0" />|<img width="1080" height="2220" alt="Screenshot_1777294088" src="https://github.com/user-attachments/assets/70bbba25-aab3-44ef-8a8d-fe38776abfbe" />| <img width="1080" height="2220" alt="Screenshot_1777294096" src="https://github.com/user-attachments/assets/910b50bf-ea3b-4918-a7df-161e8b335b5f" />|<img width="1080" height="2220" alt="Screenshot_1777294102" src="https://github.com/user-attachments/assets/cb8fc849-0248-45c2-a72b-9ca94aeb0ede" />|

---

# Overview

The app allows users to:

- Browse nightlife events in Kampala
- Filter by music/event categories
- View featured and popular events
- Open detailed event pages
- Book tickets through a simple checkout simulation
- Receive event notifications (proposed architecture)

---

# Components / Screens Created

## 1. Home / Event Listing Screen

Primary discovery screen containing:

### Components:
- Top App Bar with location (Kampala)
- Notification icon
- Search bar
- Horizontal category filters
- Featured events carousel
- Popular events list
- Event cards with CTA buttons

### Purpose:
Allows users to quickly discover nightlife experiences.

---

## 2. Event Card Component

Reusable event preview card showing:

- Event image
- Event title
- Venue
- Date / time
- Price
- Book Now button

### Purpose:
Compact summary used in listings.

---

## 3. Event Details Screen

Expanded screen for selected event.

### Components:
- Hero image header
- Event title
- Category / date / price chips
- Venue section
- Event description
- Book Now button

### Purpose:
Helps users decide before purchasing.

---

## 4. Booking Processing Screen

Intermediate loading screen after booking.

### Components:
- Circular progress indicator
- Booking status text

### Purpose:
Simulates payment / ticket reservation processing.

---

## 5. Booking Success Screen

Confirmation screen after booking.

### Components:
- Success icon
- Confirmation message
- Event summary card
- Back to Events button

### Purpose:
Provides assurance and completion feedback.

---

# What Data Each Event Has

Each event is modeled using an `Event` object.

```dart
class Event {
  final String title;
  final String venue;
  final String date;
  final String price;
  final String imageUrl;
  final String category;
  final String description;
}
```

| Field       | Purpose                                |
| ----------- | -------------------------------------- |
| title       | Name of the event                      |
| venue       | Event location                         |
| date        | Day and time                           |
| price       | Ticket price                           |
| imageUrl    | Promotional banner image               |
| category    | Genre/type (Afrobeats, Amapiano, etc.) |
| description | Full event details                     |

# How the “Book Now” Flow Works
### User Journey
From Event Card or Event Details Screen:
- User taps Book Now
- App navigates to Booking Processing Screen
- Simulated processing delay occurs
- User is redirected to Booking Success Screen
- User can return to home screen

This mimics a real production flow where:

- Payment authorization happens
- Seat/ticket inventory is reserved
- Confirmation is generated 

### Future Work
Would integrate:
- Mobile Money (MTN / Airtel)
- Card payments
- QR code ticket generation

# How Notifications Are Handled for Events
Notifications were not implemented in this demo, but a notification icon exists.

### Proposed Notification Strategy
Using Firebase Cloud Messaging (FCM).

### Notification Types
1. Event Reminder

Example:

| Your event starts tonight at 8:00 PM

2. New Events Nearby

Example:

| New rooftop party added in Kololo this weekend

3. Low Ticket Alerts

Example:

| Only 10 tickets left for Amapiano Skyline

4. Promotional Campaigns

Example:

| VIP tickets now 20% off

### User Preferences

Allow users to enable:

- Booking reminders
- Nearby events
- Promotions
- Silent notifications

# Bonus: Optimizing for Slow Internet Users
### Implemented optimization
 **Cached Images**
The project uses `cached_network_image` config which creates faster repeat loads and Reduced bandwidth usage.

**Future Work**
- Implement paginated loading
- Store last fetched events locally

# Architecture
Future work can be done to refactor the code so that each screen and class has a seperate file.

