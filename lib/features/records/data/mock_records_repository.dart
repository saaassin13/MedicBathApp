import '../domain/records_repository.dart';
import '../domain/entities.dart';

/// Mock 记录仓库实现
class MockRecordsRepository implements RecordsRepository {
  @override
  Future<List<DateGroup>> getRecords() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      DateGroup(
        dateLabel: '今天',
        items: [
          RecordItem(
            startTime: '13:11:22',
            endTime: '15:32:01',
            durationSeconds: 8400,
            cowCount: 425,
            recognitionRate: 99.8,
            avgUsage: 4.8,
          ),
          RecordItem(
            startTime: '10:05:00',
            endTime: '12:30:00',
            durationSeconds: 9000,
            cowCount: 380,
            recognitionRate: 99.5,
            avgUsage: 4.6,
          ),
        ],
      ),
      DateGroup(
        dateLabel: '昨天',
        items: [
          RecordItem(
            startTime: '08:00:00',
            endTime: '10:30:00',
            durationSeconds: 9000,
            cowCount: 410,
            recognitionRate: 99.7,
            avgUsage: 4.7,
          ),
        ],
      ),
    ];
  }
}