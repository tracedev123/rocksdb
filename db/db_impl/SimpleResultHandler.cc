//
// Created by nando on 7/6/23.
//

#include "SimpleResultHandler.h"

#include <atomic>
#include <iostream>

#include "rocksdb/trace_record_result.h"

SimpleResultHandler::SimpleResultHandler() {}
SimpleResultHandler::~SimpleResultHandler() {}

rocksdb::Status SimpleResultHandler::Handle(const rocksdb::StatusOnlyTraceExecutionResult& result) {
  cnt_++;
  latency_ += result.GetLatency();
  std::cout << "Status: " << result.GetStatus().ToString() << std::endl;
  return rocksdb::Status();
}

rocksdb::Status SimpleResultHandler::Handle(const rocksdb::SingleValueTraceExecutionResult& result) {
  cnt_++;
  latency_ += result.GetLatency();
  std::cout << "Status: " << result.GetStatus().ToString()
            << ", value: " << result.GetValue() << std::endl;
  return rocksdb::Status();
}

rocksdb::Status SimpleResultHandler::Handle(const rocksdb::MultiValuesTraceExecutionResult& result) {
  cnt_++;
  latency_ += result.GetLatency();
  size_t size = result.GetMultiStatus().size();
  for (size_t i = 0; i < size; i++) {
    std::cout << i << ", status: " << result.GetMultiStatus()[i].ToString()
              << ", value: " << result.GetValues()[i] << std::endl;
  }
  return rocksdb::Status();
}

rocksdb::Status SimpleResultHandler::Handle(const rocksdb::IteratorTraceExecutionResult& result) {
  cnt_++;
  latency_ += result.GetLatency();
  if (result.GetValid()) {
    std::cout << "Valid"
              << ", status: " << result.GetStatus().ToString()
              << ", key: " << result.GetKey().ToString()
              << ", value: " << result.GetValue().ToString() << std::endl;
  } else {
    std::cout << "Invalid"
              << ", status: " << result.GetStatus().ToString() << std::endl;
  }
  return rocksdb::Status();
}

uint64_t SimpleResultHandler::GetCount() const {
  return cnt_;
}

double SimpleResultHandler::GetAvgLatency() const {
  return 1.0 * latency_ / cnt_;
}

void SimpleResultHandler::Reset() {
  cnt_ = 0;
  latency_ = 0;
}
