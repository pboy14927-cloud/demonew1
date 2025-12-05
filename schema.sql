CREATE TABLE IF NOT EXISTS `users` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(255) NOT NULL UNIQUE,
  `name` VARCHAR(255) NOT NULL,
  `firstName` VARCHAR(255),
  `lastName` VARCHAR(255),
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `avatar` VARCHAR(255),
  `role` ENUM('administrator', 'editor', 'author', 'contributor', 'subscriber') NOT NULL DEFAULT 'subscriber',
  `bio` TEXT,
  `website` VARCHAR(255),
  `socialLinks` JSON,
  `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `posts` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL UNIQUE,
  `content` LONGTEXT,
  `status` VARCHAR(20) NOT NULL DEFAULT 'draft',
  `authorId` INT NOT NULL,
  `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `topic` VARCHAR(255),
  `categories` TEXT,
  `tags` TEXT,
  `isPage` BOOLEAN NOT NULL DEFAULT FALSE,
  `isPartnerContent` BOOLEAN NOT NULL DEFAULT FALSE,
  `featuredImage` VARCHAR(255),
  `excerpt` TEXT,
  `seo` JSON,
  `format` VARCHAR(20) DEFAULT 'standard',
  `commentStatus` VARCHAR(20) DEFAULT 'open',
  `pingStatus` VARCHAR(20) DEFAULT 'open',
  `template` VARCHAR(255) DEFAULT 'default',
  `parent` VARCHAR(255) NULL DEFAULT NULL,
  `likes` INT DEFAULT 0,
  FOREIGN KEY (`authorId`) REFERENCES `users`(`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `categories` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL UNIQUE,
  `slug` VARCHAR(255) NOT NULL UNIQUE,
  `description` TEXT,
  `parent` INT
);

CREATE TABLE IF NOT EXISTS `tags` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL UNIQUE,
  `slug` VARCHAR(255) NOT NULL UNIQUE,
  `description` TEXT
);

CREATE TABLE IF NOT EXISTS `comments` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `postId` INT NOT NULL,
  `authorId` INT,
  `guestName` VARCHAR(255),
  `guestEmail` VARCHAR(255),
  `content` TEXT NOT NULL,
  `status` VARCHAR(20) NOT NULL DEFAULT 'pending',
  `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`postId`) REFERENCES `posts`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`authorId`) REFERENCES `users`(`id`) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS `media` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `fileName` VARCHAR(255) NOT NULL,
  `fileType` VARCHAR(100) NOT NULL,
  `fileSize` INT NOT NULL,
  `altText` VARCHAR(255),
  `url` LONGTEXT,
  `data` LONGBLOB,
  `sizes` JSON,
  `uploadedBy` INT NOT NULL,
  `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`uploadedBy`) REFERENCES `users`(`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `settings` (
  `name` VARCHAR(255) NOT NULL PRIMARY KEY,
  `value` LONGTEXT
);
