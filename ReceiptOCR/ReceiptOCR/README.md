# 영수증 OCR 분석 앱

iOS 환경에서 동작하는 영수증 특화 OCR 분석 애플리케이션입니다.

## 프로젝트 개요

기존 OCR 앱들은 단순 텍스트 추출에 집중되어 있어 핵심 정보를 직관적으로 확인하기 어렵습니다.
본 앱은 영수증 이미지에서 상호명, 날짜, 총액을 자동으로 추출하여 사용자에게 직관적으로 제공합니다.

## 주요 기능

- 갤러리에서 영수증 이미지 선택
- 이미지 전처리 (흑백 변환, 대비 증가, 2배 확대)
- Vision Framework 기반 OCR 텍스트 추출
- 상호명 / 날짜 / 총액 자동 분석
- 분석 기록 저장 및 조회

## 기술 스택

| 항목 | 내용 |
|------|------|
| 언어 | Swift |
| UI | Storyboard |
| 아키텍처 | MVC |
| OCR | Vision Framework |
| 이미지 처리 | CoreImage |
| 데이터 저장 | UserDefaults |
| 개발 환경 | Xcode, iOS 14.5 |

## 프로젝트 구조

ReceiptOCR/
├── Models/
│   └── ReceiptData.swift
├── Views/
│   └── Main.storyboard
├── Controllers/
│   ├── HomeViewController.swift
│   ├── ResultViewController.swift
│   ├── HistoryViewController.swift
│   └── OCRController.swift
└── Services/
    ├── OCRService.swift
    ├── ImageProcessingService.swift
    └── TextAnalysisService.swift

## 실행 화면

| Home | Result | History |
|------|--------|---------|
| 이미지 선택 화면 | 분석 결과 화면 | 기록 조회 화면 |

## 제약사항

- Vision Framework 기반 OCR 특성상 한국어 인식률이 낮을 수 있음
- 시뮬레이터 환경에서 테스트 진행
- 영수증 양식에 따라 분석 정확도 차이 있을 수 있음
