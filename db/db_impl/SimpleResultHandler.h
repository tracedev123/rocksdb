//
// Created by nando on 7/6/23.
//

#ifndef ROCKSDB_SIMPLERESULTHANDLER_H
#define ROCKSDB_SIMPLERESULTHANDLER_H

#include <atomic>

#include "rocksdb/trace_record_result.h"

class SimpleResultHandler : public rocksdb::TraceRecordResult::Handler {
 public:
  SimpleResultHandler();
  ~SimpleResultHandler() override;

  rocksdb::Status Handle(const rocksdb::StatusOnlyTraceExecutionResult& result) override;
  rocksdb::Status Handle(const rocksdb::SingleValueTraceExecutionResult& result) override;
  rocksdb::Status Handle(const rocksdb::MultiValuesTraceExecutionResult& result) override;
  rocksdb::Status Handle(const rocksdb::IteratorTraceExecutionResult& result) override;

  uint64_t GetCount() const;
  double GetAvgLatency() const;
  void Reset();

 private:
  std::atomic<uint64_t> cnt_{0};
  std::atomic<uint64_t> latency_{0};
};

#endif  // ROCKSDB_SIMPLERESULTHANDLER_H
