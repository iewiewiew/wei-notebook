---
name: wangmanyu-dev
description: Development skill for the Wang Manyu Database project (王曼昱数据库). Use when adding new pages, components, or features to this Next.js fan website. Covers project conventions, styling guidelines, data structure patterns, and feature implementation workflows.
---

# Wang Manyu Database Development Skill

This skill guides development for the Wang Manyu Database project - a Next.js fan website for Chinese table tennis player Wang Manyu.

## Project Overview

- **Tech Stack**: Next.js 15+ (App Router) + React + TypeScript + Tailwind CSS + Framer Motion
- **Theme**: Amber/gold color scheme representing championship glory
- **Data**: JSON files in `/public/data/`, images in `/public/images/`
- **Purpose**: Fan-oriented educational website aggregating match data, achievements, media, and career information

## Quick Reference

### Color System

```
Primary: amber-500/600 (championship gold)
Background: gradient from FAFAFA to F5F0E8 (warm white)
Text: stone-600/700/800
Category Colors:
  - 三大赛 (Three Majors): rose-500
  - 洲际赛 (Continental): emerald-500
  - 国内赛 (National): sky-500
  - WTT系列: violet-500
  - ITTF系列: purple-500
```

### Key Directories

```
src/
├── app/           # Pages (App Router)
├── components/    # React components by feature
├── lib/           # Utilities, constants, API clients
├── types/         # TypeScript interfaces
└── config/        # Configuration

public/
├── data/          # JSON data files
└── images/        # Static images
```

### Common Imports

```tsx
// Types
import type { MatchData, ChampionPhoto } from '@/types';

// Utilities
import { cn } from '@/lib/utils/helpers';
import { MATCH_CATEGORIES, PROJECT_TYPES } from '@/lib/constants';

// Components
import ImageLightbox from '@/components/common/ImageLightbox';
```

## Feature Implementation Workflow

### Step 1: Data Structure

1. Define TypeScript interface in `src/types/index.ts`
2. Create/modify JSON data file in `public/data/`
3. Add API route in `src/app/api/data/[resource]/route.ts` if needed

### Step 2: Component Development

1. Create component in appropriate `src/components/[feature]/` directory
2. Follow naming convention: `[Feature]Section.tsx`, `[Feature]Card.tsx`, `[Feature]Table.tsx`
3. Use Tailwind CSS with project color system
4. Add Framer Motion animations for enhanced UX

### Step 3: Page Integration

1. Create/update page in `src/app/[route]/page.tsx`
2. Add navigation entry in `src/components/layout/Header.tsx` if new page
3. Update sitemap in `src/app/sitemap.ts` if public page

## Component Patterns

### Card Component

```tsx
export function FeatureCard({ data }: { data: FeatureType }) {
  return (
    <div className="group bg-white rounded-2xl shadow-sm hover:shadow-md 
                    transition-all duration-300 hover:-translate-y-1 p-6">
      {/* Content with amber accents */}
      <h3 className="text-lg font-semibold text-stone-800">{data.title}</h3>
      <p className="text-stone-600 mt-2">{data.description}</p>
    </div>
  );
}
```

### Section with Animation

```tsx
'use client';

import { motion } from 'framer-motion';

export function FeatureSection() {
  return (
    <motion.section
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.5 }}
      className="py-12"
    >
      {/* Section content */}
    </motion.section>
  );
}
```

### Filter Component

```tsx
'use client';

import { useState } from 'react';
import { cn } from '@/lib/utils/helpers';

const FILTERS = ['全部', '选项1', '选项2'] as const;

export function FilterTabs() {
  const [active, setActive] = useState<string>('全部');

  return (
    <div className="flex gap-2 flex-wrap">
      {FILTERS.map((filter) => (
        <button
          key={filter}
          onClick={() => setActive(filter)}
          className={cn(
            'px-4 py-2 rounded-full text-sm transition-colors',
            active === filter
              ? 'bg-amber-500 text-white'
              : 'bg-stone-100 text-stone-600 hover:bg-stone-200'
          )}
        >
          {filter}
        </button>
      ))}
    </div>
  );
}
```

## Data File Guidelines

### JSON Structure

```json
{
  "items": [
    {
      "id": "unique-id",
      "title": "Item Title",
      "date": "2026-01-01",
      "imageUrl": "/images/category/filename.jpg",
      "description": "Description text"
    }
  ]
}
```

### Image Conventions

- Champion photos: `/images/champion-photos/{年份}{赛事名称}-{项目}.jpg`
- Business: `/images/business/business-{序号}-{日期}-{品牌}.{ext}`
- Magazine: `/images/magazine/{杂志名称}/{期号}/`

## Styling Guidelines

### Do's

- Use `rounded-2xl` for cards and containers
- Add `transition-all duration-300` for hover effects
- Include `hover:-translate-y-1` for card lift effect
- Use `backdrop-blur-sm` for glass effects
- Apply `text-stone-*` for text colors

### Don'ts

- Don't use generic colors (blue-500, red-500) - use category colors
- Don't hardcode pixel values - use Tailwind spacing
- Don't skip responsive design - always consider mobile first
- Don't forget dark mode contrast when using transparency

## API Route Pattern

```tsx
// src/app/api/data/[resource]/route.ts
import { NextResponse } from 'next/server';
import data from '@/public/data/[resource].json';

export async function GET() {
  return NextResponse.json(data);
}
```

## Common Utilities

### Date Formatting

```tsx
// Format date to Chinese style
const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('zh-CN', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });
};
```

### Category Badge

```tsx
const CATEGORY_COLORS: Record<string, string> = {
  '三大赛': 'bg-rose-100 text-rose-700',
  '洲际赛': 'bg-emerald-100 text-emerald-700',
  '国内赛': 'bg-sky-100 text-sky-700',
  'WTT': 'bg-violet-100 text-violet-700',
  'ITTF': 'bg-purple-100 text-purple-700',
};

export function CategoryBadge({ category }: { category: string }) {
  return (
    <span className={cn(
      'px-2 py-1 rounded-full text-xs font-medium',
      CATEGORY_COLORS[category] || 'bg-stone-100 text-stone-700'
    )}>
      {category}
    </span>
  );
}
```

## Pre-Commit Checklist

- [ ] TypeScript types defined/updated
- [ ] Components follow naming conventions
- [ ] Tailwind classes use project color system
- [ ] Responsive design tested (mobile + desktop)
- [ ] Images optimized and in correct directory
- [ ] No hardcoded text that should be in data files
- [ ] Animation performance acceptable
