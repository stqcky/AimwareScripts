// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: engine_gcmessages.proto

#ifndef GOOGLE_PROTOBUF_INCLUDED_engine_5fgcmessages_2eproto
#define GOOGLE_PROTOBUF_INCLUDED_engine_5fgcmessages_2eproto

#include <limits>
#include <string>

#include <google/protobuf/port_def.inc>
#if PROTOBUF_VERSION < 3019000
#error This file was generated by a newer version of protoc which is
#error incompatible with your Protocol Buffer headers. Please update
#error your headers.
#endif
#if 3019001 < PROTOBUF_MIN_PROTOC_VERSION
#error This file was generated by an older version of protoc which is
#error incompatible with your Protocol Buffer headers. Please
#error regenerate this file with a newer version of protoc.
#endif

#include <google/protobuf/port_undef.inc>
#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/arena.h>
#include <google/protobuf/arenastring.h>
#include <google/protobuf/generated_message_table_driven.h>
#include <google/protobuf/generated_message_util.h>
#include <google/protobuf/metadata_lite.h>
#include <google/protobuf/generated_message_reflection.h>
#include <google/protobuf/message.h>
#include <google/protobuf/repeated_field.h>  // IWYU pragma: export
#include <google/protobuf/extension_set.h>  // IWYU pragma: export
#include <google/protobuf/unknown_field_set.h>
#include <google/protobuf/descriptor.pb.h>
// @@protoc_insertion_point(includes)
#include <google/protobuf/port_def.inc>
#define PROTOBUF_INTERNAL_EXPORT_engine_5fgcmessages_2eproto
PROTOBUF_NAMESPACE_OPEN
namespace internal {
class AnyMetadata;
}  // namespace internal
PROTOBUF_NAMESPACE_CLOSE

// Internal implementation detail -- do not use these members.
struct TableStruct_engine_5fgcmessages_2eproto {
  static const ::PROTOBUF_NAMESPACE_ID::internal::ParseTableField entries[]
    PROTOBUF_SECTION_VARIABLE(protodesc_cold);
  static const ::PROTOBUF_NAMESPACE_ID::internal::AuxiliaryParseTableField aux[]
    PROTOBUF_SECTION_VARIABLE(protodesc_cold);
  static const ::PROTOBUF_NAMESPACE_ID::internal::ParseTable schema[1]
    PROTOBUF_SECTION_VARIABLE(protodesc_cold);
  static const ::PROTOBUF_NAMESPACE_ID::internal::FieldMetadata field_metadata[];
  static const ::PROTOBUF_NAMESPACE_ID::internal::SerializationTable serialization_table[];
  static const uint32_t offsets[];
};
extern const ::PROTOBUF_NAMESPACE_ID::internal::DescriptorTable descriptor_table_engine_5fgcmessages_2eproto;
class CEngineGotvSyncPacket;
struct CEngineGotvSyncPacketDefaultTypeInternal;
extern CEngineGotvSyncPacketDefaultTypeInternal _CEngineGotvSyncPacket_default_instance_;
PROTOBUF_NAMESPACE_OPEN
template<> ::CEngineGotvSyncPacket* Arena::CreateMaybeMessage<::CEngineGotvSyncPacket>(Arena*);
PROTOBUF_NAMESPACE_CLOSE

// ===================================================================

class CEngineGotvSyncPacket final :
    public ::PROTOBUF_NAMESPACE_ID::Message /* @@protoc_insertion_point(class_definition:CEngineGotvSyncPacket) */ {
 public:
  inline CEngineGotvSyncPacket() : CEngineGotvSyncPacket(nullptr) {}
  ~CEngineGotvSyncPacket() override;
  explicit constexpr CEngineGotvSyncPacket(::PROTOBUF_NAMESPACE_ID::internal::ConstantInitialized);

  CEngineGotvSyncPacket(const CEngineGotvSyncPacket& from);
  CEngineGotvSyncPacket(CEngineGotvSyncPacket&& from) noexcept
    : CEngineGotvSyncPacket() {
    *this = ::std::move(from);
  }

  inline CEngineGotvSyncPacket& operator=(const CEngineGotvSyncPacket& from) {
    CopyFrom(from);
    return *this;
  }
  inline CEngineGotvSyncPacket& operator=(CEngineGotvSyncPacket&& from) noexcept {
    if (this == &from) return *this;
    if (GetOwningArena() == from.GetOwningArena()
  #ifdef PROTOBUF_FORCE_COPY_IN_MOVE
        && GetOwningArena() != nullptr
  #endif  // !PROTOBUF_FORCE_COPY_IN_MOVE
    ) {
      InternalSwap(&from);
    } else {
      CopyFrom(from);
    }
    return *this;
  }

  inline const ::PROTOBUF_NAMESPACE_ID::UnknownFieldSet& unknown_fields() const {
    return _internal_metadata_.unknown_fields<::PROTOBUF_NAMESPACE_ID::UnknownFieldSet>(::PROTOBUF_NAMESPACE_ID::UnknownFieldSet::default_instance);
  }
  inline ::PROTOBUF_NAMESPACE_ID::UnknownFieldSet* mutable_unknown_fields() {
    return _internal_metadata_.mutable_unknown_fields<::PROTOBUF_NAMESPACE_ID::UnknownFieldSet>();
  }

  static const ::PROTOBUF_NAMESPACE_ID::Descriptor* descriptor() {
    return GetDescriptor();
  }
  static const ::PROTOBUF_NAMESPACE_ID::Descriptor* GetDescriptor() {
    return default_instance().GetMetadata().descriptor;
  }
  static const ::PROTOBUF_NAMESPACE_ID::Reflection* GetReflection() {
    return default_instance().GetMetadata().reflection;
  }
  static const CEngineGotvSyncPacket& default_instance() {
    return *internal_default_instance();
  }
  static inline const CEngineGotvSyncPacket* internal_default_instance() {
    return reinterpret_cast<const CEngineGotvSyncPacket*>(
               &_CEngineGotvSyncPacket_default_instance_);
  }
  static constexpr int kIndexInFileMessages =
    0;

  friend void swap(CEngineGotvSyncPacket& a, CEngineGotvSyncPacket& b) {
    a.Swap(&b);
  }
  inline void Swap(CEngineGotvSyncPacket* other) {
    if (other == this) return;
  #ifdef PROTOBUF_FORCE_COPY_IN_SWAP
    if (GetOwningArena() != nullptr &&
        GetOwningArena() == other->GetOwningArena()) {
   #else  // PROTOBUF_FORCE_COPY_IN_SWAP
    if (GetOwningArena() == other->GetOwningArena()) {
  #endif  // !PROTOBUF_FORCE_COPY_IN_SWAP
      InternalSwap(other);
    } else {
      ::PROTOBUF_NAMESPACE_ID::internal::GenericSwap(this, other);
    }
  }
  void UnsafeArenaSwap(CEngineGotvSyncPacket* other) {
    if (other == this) return;
    GOOGLE_DCHECK(GetOwningArena() == other->GetOwningArena());
    InternalSwap(other);
  }

  // implements Message ----------------------------------------------

  CEngineGotvSyncPacket* New(::PROTOBUF_NAMESPACE_ID::Arena* arena = nullptr) const final {
    return CreateMaybeMessage<CEngineGotvSyncPacket>(arena);
  }
  using ::PROTOBUF_NAMESPACE_ID::Message::CopyFrom;
  void CopyFrom(const CEngineGotvSyncPacket& from);
  using ::PROTOBUF_NAMESPACE_ID::Message::MergeFrom;
  void MergeFrom(const CEngineGotvSyncPacket& from);
  private:
  static void MergeImpl(::PROTOBUF_NAMESPACE_ID::Message* to, const ::PROTOBUF_NAMESPACE_ID::Message& from);
  public:
  PROTOBUF_ATTRIBUTE_REINITIALIZES void Clear() final;
  bool IsInitialized() const final;

  size_t ByteSizeLong() const final;
  const char* _InternalParse(const char* ptr, ::PROTOBUF_NAMESPACE_ID::internal::ParseContext* ctx) final;
  uint8_t* _InternalSerialize(
      uint8_t* target, ::PROTOBUF_NAMESPACE_ID::io::EpsCopyOutputStream* stream) const final;
  int GetCachedSize() const final { return _cached_size_.Get(); }

  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const final;
  void InternalSwap(CEngineGotvSyncPacket* other);

  private:
  friend class ::PROTOBUF_NAMESPACE_ID::internal::AnyMetadata;
  static ::PROTOBUF_NAMESPACE_ID::StringPiece FullMessageName() {
    return "CEngineGotvSyncPacket";
  }
  protected:
  explicit CEngineGotvSyncPacket(::PROTOBUF_NAMESPACE_ID::Arena* arena,
                       bool is_message_owned = false);
  private:
  static void ArenaDtor(void* object);
  inline void RegisterArenaDtor(::PROTOBUF_NAMESPACE_ID::Arena* arena);
  public:

  static const ClassData _class_data_;
  const ::PROTOBUF_NAMESPACE_ID::Message::ClassData*GetClassData() const final;

  ::PROTOBUF_NAMESPACE_ID::Metadata GetMetadata() const final;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  enum : int {
    kMatchIdFieldNumber = 1,
    kInstanceIdFieldNumber = 2,
    kSignupfragmentFieldNumber = 3,
    kCurrentfragmentFieldNumber = 4,
    kTickrateFieldNumber = 5,
    kTickFieldNumber = 6,
    kRtdelayFieldNumber = 8,
    kRcvageFieldNumber = 9,
    kKeyframeIntervalFieldNumber = 10,
    kCdndelayFieldNumber = 11,
  };
  // optional uint64 match_id = 1;
  bool has_match_id() const;
  private:
  bool _internal_has_match_id() const;
  public:
  void clear_match_id();
  uint64_t match_id() const;
  void set_match_id(uint64_t value);
  private:
  uint64_t _internal_match_id() const;
  void _internal_set_match_id(uint64_t value);
  public:

  // optional uint32 instance_id = 2;
  bool has_instance_id() const;
  private:
  bool _internal_has_instance_id() const;
  public:
  void clear_instance_id();
  uint32_t instance_id() const;
  void set_instance_id(uint32_t value);
  private:
  uint32_t _internal_instance_id() const;
  void _internal_set_instance_id(uint32_t value);
  public:

  // optional uint32 signupfragment = 3;
  bool has_signupfragment() const;
  private:
  bool _internal_has_signupfragment() const;
  public:
  void clear_signupfragment();
  uint32_t signupfragment() const;
  void set_signupfragment(uint32_t value);
  private:
  uint32_t _internal_signupfragment() const;
  void _internal_set_signupfragment(uint32_t value);
  public:

  // optional uint32 currentfragment = 4;
  bool has_currentfragment() const;
  private:
  bool _internal_has_currentfragment() const;
  public:
  void clear_currentfragment();
  uint32_t currentfragment() const;
  void set_currentfragment(uint32_t value);
  private:
  uint32_t _internal_currentfragment() const;
  void _internal_set_currentfragment(uint32_t value);
  public:

  // optional float tickrate = 5;
  bool has_tickrate() const;
  private:
  bool _internal_has_tickrate() const;
  public:
  void clear_tickrate();
  float tickrate() const;
  void set_tickrate(float value);
  private:
  float _internal_tickrate() const;
  void _internal_set_tickrate(float value);
  public:

  // optional uint32 tick = 6;
  bool has_tick() const;
  private:
  bool _internal_has_tick() const;
  public:
  void clear_tick();
  uint32_t tick() const;
  void set_tick(uint32_t value);
  private:
  uint32_t _internal_tick() const;
  void _internal_set_tick(uint32_t value);
  public:

  // optional float rtdelay = 8;
  bool has_rtdelay() const;
  private:
  bool _internal_has_rtdelay() const;
  public:
  void clear_rtdelay();
  float rtdelay() const;
  void set_rtdelay(float value);
  private:
  float _internal_rtdelay() const;
  void _internal_set_rtdelay(float value);
  public:

  // optional float rcvage = 9;
  bool has_rcvage() const;
  private:
  bool _internal_has_rcvage() const;
  public:
  void clear_rcvage();
  float rcvage() const;
  void set_rcvage(float value);
  private:
  float _internal_rcvage() const;
  void _internal_set_rcvage(float value);
  public:

  // optional float keyframe_interval = 10;
  bool has_keyframe_interval() const;
  private:
  bool _internal_has_keyframe_interval() const;
  public:
  void clear_keyframe_interval();
  float keyframe_interval() const;
  void set_keyframe_interval(float value);
  private:
  float _internal_keyframe_interval() const;
  void _internal_set_keyframe_interval(float value);
  public:

  // optional uint32 cdndelay = 11;
  bool has_cdndelay() const;
  private:
  bool _internal_has_cdndelay() const;
  public:
  void clear_cdndelay();
  uint32_t cdndelay() const;
  void set_cdndelay(uint32_t value);
  private:
  uint32_t _internal_cdndelay() const;
  void _internal_set_cdndelay(uint32_t value);
  public:

  // @@protoc_insertion_point(class_scope:CEngineGotvSyncPacket)
 private:
  class _Internal;

  template <typename T> friend class ::PROTOBUF_NAMESPACE_ID::Arena::InternalHelper;
  typedef void InternalArenaConstructable_;
  typedef void DestructorSkippable_;
  ::PROTOBUF_NAMESPACE_ID::internal::HasBits<1> _has_bits_;
  mutable ::PROTOBUF_NAMESPACE_ID::internal::CachedSize _cached_size_;
  uint64_t match_id_;
  uint32_t instance_id_;
  uint32_t signupfragment_;
  uint32_t currentfragment_;
  float tickrate_;
  uint32_t tick_;
  float rtdelay_;
  float rcvage_;
  float keyframe_interval_;
  uint32_t cdndelay_;
  friend struct ::TableStruct_engine_5fgcmessages_2eproto;
};
// ===================================================================


// ===================================================================

#ifdef __GNUC__
  #pragma GCC diagnostic push
  #pragma GCC diagnostic ignored "-Wstrict-aliasing"
#endif  // __GNUC__
// CEngineGotvSyncPacket

// optional uint64 match_id = 1;
inline bool CEngineGotvSyncPacket::_internal_has_match_id() const {
  bool value = (_has_bits_[0] & 0x00000001u) != 0;
  return value;
}
inline bool CEngineGotvSyncPacket::has_match_id() const {
  return _internal_has_match_id();
}
inline void CEngineGotvSyncPacket::clear_match_id() {
  match_id_ = uint64_t{0u};
  _has_bits_[0] &= ~0x00000001u;
}
inline uint64_t CEngineGotvSyncPacket::_internal_match_id() const {
  return match_id_;
}
inline uint64_t CEngineGotvSyncPacket::match_id() const {
  // @@protoc_insertion_point(field_get:CEngineGotvSyncPacket.match_id)
  return _internal_match_id();
}
inline void CEngineGotvSyncPacket::_internal_set_match_id(uint64_t value) {
  _has_bits_[0] |= 0x00000001u;
  match_id_ = value;
}
inline void CEngineGotvSyncPacket::set_match_id(uint64_t value) {
  _internal_set_match_id(value);
  // @@protoc_insertion_point(field_set:CEngineGotvSyncPacket.match_id)
}

// optional uint32 instance_id = 2;
inline bool CEngineGotvSyncPacket::_internal_has_instance_id() const {
  bool value = (_has_bits_[0] & 0x00000002u) != 0;
  return value;
}
inline bool CEngineGotvSyncPacket::has_instance_id() const {
  return _internal_has_instance_id();
}
inline void CEngineGotvSyncPacket::clear_instance_id() {
  instance_id_ = 0u;
  _has_bits_[0] &= ~0x00000002u;
}
inline uint32_t CEngineGotvSyncPacket::_internal_instance_id() const {
  return instance_id_;
}
inline uint32_t CEngineGotvSyncPacket::instance_id() const {
  // @@protoc_insertion_point(field_get:CEngineGotvSyncPacket.instance_id)
  return _internal_instance_id();
}
inline void CEngineGotvSyncPacket::_internal_set_instance_id(uint32_t value) {
  _has_bits_[0] |= 0x00000002u;
  instance_id_ = value;
}
inline void CEngineGotvSyncPacket::set_instance_id(uint32_t value) {
  _internal_set_instance_id(value);
  // @@protoc_insertion_point(field_set:CEngineGotvSyncPacket.instance_id)
}

// optional uint32 signupfragment = 3;
inline bool CEngineGotvSyncPacket::_internal_has_signupfragment() const {
  bool value = (_has_bits_[0] & 0x00000004u) != 0;
  return value;
}
inline bool CEngineGotvSyncPacket::has_signupfragment() const {
  return _internal_has_signupfragment();
}
inline void CEngineGotvSyncPacket::clear_signupfragment() {
  signupfragment_ = 0u;
  _has_bits_[0] &= ~0x00000004u;
}
inline uint32_t CEngineGotvSyncPacket::_internal_signupfragment() const {
  return signupfragment_;
}
inline uint32_t CEngineGotvSyncPacket::signupfragment() const {
  // @@protoc_insertion_point(field_get:CEngineGotvSyncPacket.signupfragment)
  return _internal_signupfragment();
}
inline void CEngineGotvSyncPacket::_internal_set_signupfragment(uint32_t value) {
  _has_bits_[0] |= 0x00000004u;
  signupfragment_ = value;
}
inline void CEngineGotvSyncPacket::set_signupfragment(uint32_t value) {
  _internal_set_signupfragment(value);
  // @@protoc_insertion_point(field_set:CEngineGotvSyncPacket.signupfragment)
}

// optional uint32 currentfragment = 4;
inline bool CEngineGotvSyncPacket::_internal_has_currentfragment() const {
  bool value = (_has_bits_[0] & 0x00000008u) != 0;
  return value;
}
inline bool CEngineGotvSyncPacket::has_currentfragment() const {
  return _internal_has_currentfragment();
}
inline void CEngineGotvSyncPacket::clear_currentfragment() {
  currentfragment_ = 0u;
  _has_bits_[0] &= ~0x00000008u;
}
inline uint32_t CEngineGotvSyncPacket::_internal_currentfragment() const {
  return currentfragment_;
}
inline uint32_t CEngineGotvSyncPacket::currentfragment() const {
  // @@protoc_insertion_point(field_get:CEngineGotvSyncPacket.currentfragment)
  return _internal_currentfragment();
}
inline void CEngineGotvSyncPacket::_internal_set_currentfragment(uint32_t value) {
  _has_bits_[0] |= 0x00000008u;
  currentfragment_ = value;
}
inline void CEngineGotvSyncPacket::set_currentfragment(uint32_t value) {
  _internal_set_currentfragment(value);
  // @@protoc_insertion_point(field_set:CEngineGotvSyncPacket.currentfragment)
}

// optional float tickrate = 5;
inline bool CEngineGotvSyncPacket::_internal_has_tickrate() const {
  bool value = (_has_bits_[0] & 0x00000010u) != 0;
  return value;
}
inline bool CEngineGotvSyncPacket::has_tickrate() const {
  return _internal_has_tickrate();
}
inline void CEngineGotvSyncPacket::clear_tickrate() {
  tickrate_ = 0;
  _has_bits_[0] &= ~0x00000010u;
}
inline float CEngineGotvSyncPacket::_internal_tickrate() const {
  return tickrate_;
}
inline float CEngineGotvSyncPacket::tickrate() const {
  // @@protoc_insertion_point(field_get:CEngineGotvSyncPacket.tickrate)
  return _internal_tickrate();
}
inline void CEngineGotvSyncPacket::_internal_set_tickrate(float value) {
  _has_bits_[0] |= 0x00000010u;
  tickrate_ = value;
}
inline void CEngineGotvSyncPacket::set_tickrate(float value) {
  _internal_set_tickrate(value);
  // @@protoc_insertion_point(field_set:CEngineGotvSyncPacket.tickrate)
}

// optional uint32 tick = 6;
inline bool CEngineGotvSyncPacket::_internal_has_tick() const {
  bool value = (_has_bits_[0] & 0x00000020u) != 0;
  return value;
}
inline bool CEngineGotvSyncPacket::has_tick() const {
  return _internal_has_tick();
}
inline void CEngineGotvSyncPacket::clear_tick() {
  tick_ = 0u;
  _has_bits_[0] &= ~0x00000020u;
}
inline uint32_t CEngineGotvSyncPacket::_internal_tick() const {
  return tick_;
}
inline uint32_t CEngineGotvSyncPacket::tick() const {
  // @@protoc_insertion_point(field_get:CEngineGotvSyncPacket.tick)
  return _internal_tick();
}
inline void CEngineGotvSyncPacket::_internal_set_tick(uint32_t value) {
  _has_bits_[0] |= 0x00000020u;
  tick_ = value;
}
inline void CEngineGotvSyncPacket::set_tick(uint32_t value) {
  _internal_set_tick(value);
  // @@protoc_insertion_point(field_set:CEngineGotvSyncPacket.tick)
}

// optional float rtdelay = 8;
inline bool CEngineGotvSyncPacket::_internal_has_rtdelay() const {
  bool value = (_has_bits_[0] & 0x00000040u) != 0;
  return value;
}
inline bool CEngineGotvSyncPacket::has_rtdelay() const {
  return _internal_has_rtdelay();
}
inline void CEngineGotvSyncPacket::clear_rtdelay() {
  rtdelay_ = 0;
  _has_bits_[0] &= ~0x00000040u;
}
inline float CEngineGotvSyncPacket::_internal_rtdelay() const {
  return rtdelay_;
}
inline float CEngineGotvSyncPacket::rtdelay() const {
  // @@protoc_insertion_point(field_get:CEngineGotvSyncPacket.rtdelay)
  return _internal_rtdelay();
}
inline void CEngineGotvSyncPacket::_internal_set_rtdelay(float value) {
  _has_bits_[0] |= 0x00000040u;
  rtdelay_ = value;
}
inline void CEngineGotvSyncPacket::set_rtdelay(float value) {
  _internal_set_rtdelay(value);
  // @@protoc_insertion_point(field_set:CEngineGotvSyncPacket.rtdelay)
}

// optional float rcvage = 9;
inline bool CEngineGotvSyncPacket::_internal_has_rcvage() const {
  bool value = (_has_bits_[0] & 0x00000080u) != 0;
  return value;
}
inline bool CEngineGotvSyncPacket::has_rcvage() const {
  return _internal_has_rcvage();
}
inline void CEngineGotvSyncPacket::clear_rcvage() {
  rcvage_ = 0;
  _has_bits_[0] &= ~0x00000080u;
}
inline float CEngineGotvSyncPacket::_internal_rcvage() const {
  return rcvage_;
}
inline float CEngineGotvSyncPacket::rcvage() const {
  // @@protoc_insertion_point(field_get:CEngineGotvSyncPacket.rcvage)
  return _internal_rcvage();
}
inline void CEngineGotvSyncPacket::_internal_set_rcvage(float value) {
  _has_bits_[0] |= 0x00000080u;
  rcvage_ = value;
}
inline void CEngineGotvSyncPacket::set_rcvage(float value) {
  _internal_set_rcvage(value);
  // @@protoc_insertion_point(field_set:CEngineGotvSyncPacket.rcvage)
}

// optional float keyframe_interval = 10;
inline bool CEngineGotvSyncPacket::_internal_has_keyframe_interval() const {
  bool value = (_has_bits_[0] & 0x00000100u) != 0;
  return value;
}
inline bool CEngineGotvSyncPacket::has_keyframe_interval() const {
  return _internal_has_keyframe_interval();
}
inline void CEngineGotvSyncPacket::clear_keyframe_interval() {
  keyframe_interval_ = 0;
  _has_bits_[0] &= ~0x00000100u;
}
inline float CEngineGotvSyncPacket::_internal_keyframe_interval() const {
  return keyframe_interval_;
}
inline float CEngineGotvSyncPacket::keyframe_interval() const {
  // @@protoc_insertion_point(field_get:CEngineGotvSyncPacket.keyframe_interval)
  return _internal_keyframe_interval();
}
inline void CEngineGotvSyncPacket::_internal_set_keyframe_interval(float value) {
  _has_bits_[0] |= 0x00000100u;
  keyframe_interval_ = value;
}
inline void CEngineGotvSyncPacket::set_keyframe_interval(float value) {
  _internal_set_keyframe_interval(value);
  // @@protoc_insertion_point(field_set:CEngineGotvSyncPacket.keyframe_interval)
}

// optional uint32 cdndelay = 11;
inline bool CEngineGotvSyncPacket::_internal_has_cdndelay() const {
  bool value = (_has_bits_[0] & 0x00000200u) != 0;
  return value;
}
inline bool CEngineGotvSyncPacket::has_cdndelay() const {
  return _internal_has_cdndelay();
}
inline void CEngineGotvSyncPacket::clear_cdndelay() {
  cdndelay_ = 0u;
  _has_bits_[0] &= ~0x00000200u;
}
inline uint32_t CEngineGotvSyncPacket::_internal_cdndelay() const {
  return cdndelay_;
}
inline uint32_t CEngineGotvSyncPacket::cdndelay() const {
  // @@protoc_insertion_point(field_get:CEngineGotvSyncPacket.cdndelay)
  return _internal_cdndelay();
}
inline void CEngineGotvSyncPacket::_internal_set_cdndelay(uint32_t value) {
  _has_bits_[0] |= 0x00000200u;
  cdndelay_ = value;
}
inline void CEngineGotvSyncPacket::set_cdndelay(uint32_t value) {
  _internal_set_cdndelay(value);
  // @@protoc_insertion_point(field_set:CEngineGotvSyncPacket.cdndelay)
}

#ifdef __GNUC__
  #pragma GCC diagnostic pop
#endif  // __GNUC__

// @@protoc_insertion_point(namespace_scope)


// @@protoc_insertion_point(global_scope)

#include <google/protobuf/port_undef.inc>
#endif  // GOOGLE_PROTOBUF_INCLUDED_GOOGLE_PROTOBUF_INCLUDED_engine_5fgcmessages_2eproto
