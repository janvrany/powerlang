/*
 * Copyright (c) 2019 Javier Pimas, Jan Vrany

 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#ifndef _OBJECT_H_
#define _OBJECT_H_

#include <Assert.h>
#include <object_format.h>
#include <string>
#include <Util.h>

namespace S9 {

typedef enum
{
    IsBytes = pst::small_header_t::Flag_isBytes,
    IsVariable = pst::small_header_t::Flag_isArrayed,
    IsNamed = pst::small_header_t::Flag_isNamed,
    IsRemembered = pst::small_header_t::Flag_isRemembered,
    IsWeak = pst::small_header_t::Flag_isWeak,
    HasBeenSeen = pst::small_header_t::Flag_hasBeenSeen,
    IsSecondGen = pst::small_header_t::Flag_isSecondGen,
    IsSmall = pst::small_header_t::Flag_isSmall

} VMObjectFlags;

/**
 * Class `VMObject` represent a smalltalk object on an object heap
 * and provides basic access to object contents.
 *
 * Note: within a C++ code, NEVER use raw pointer (i.e, `Object*`
 * to represent a reference to an object. ALWAYS use `OOP` for that,
 * i.e.,
 *
 *     OOP someObject = ...; // good
 *     Object* someObject = ...; // BAD, don't do that!
 *
 * The reason is that `OOP` is (will be) safe w.r.t moving GC, i.e,
 * when GC kicks in, it automatically updates (will update) all
 * `OOP` references to that object when it moves it.
 *
 * For details, see class `OOP` below.
 */
struct VMObject : private pst::oop_t
{
  public:
    VMObject* behavior()
    {
        return reinterpret_cast<VMObject*>(this->small_header()->behavior);
    }

    VMObjectFlags flags()
    {
        return (VMObjectFlags)(this->small_header()->flags);
    }

    /**
     * Return a slot (pointer) of this object at given
     * index. Index starts at 0. This CAN be used to access
     * both named and indexed slots. This MUST be used only
     * with pointer-indexed objects.
     */
    VMObject* slot(uint32_t index);

    /**
     * Return a byte of this object at given index. Index
     * starts at 0. This MUST be used only with byte-indexed
     * objects.
     */
    uint8_t byte(uint32_t index);

    /**
     * Return size of an object. This is a number of slots
     * (pointers) for pointer-indexed objects or number of
     * bytes without padding for byte-indexed objects.
     */
    size_t size() { return this->_size(); }

    /**
     * Return size of an object in bytes, *excluding* header
     * and excluding eventual alignment (for byte objects)
     */
    size_t sizeInBytes() { return this->_sizeInBytes(); }

    /**
     * Return aligned size of an object in bytes, *excluding* header.
     *
     */
    size_t sizeInBytesAligned() { return align(this->sizeInBytes(), 8); }

    /**
     * Given a pointer to the beginning of an object header,
     * return an OOP representing the object.
     */
    static VMObject* headerToObject(void* header);

    static void initializeSpecialObjects(VMObject* specialObjectsArray);

    class InvalidAccess
    {
      protected:
        std::string msg;

      public:
        InvalidAccess(const char* msg)
          : msg(msg)
        {}

        InvalidAccess(std::string msg)
          : msg(msg)
        {}
    };
};

// Here we just need to make sure the struct Object is empty.
// However, in C++, size of an empty struct / class is 1 byte,
// hence the `... == 1`
static_assert(sizeof(VMObject) == 1);

/**
 * (Template) class `OOP` represents a *reference* to a smalltalk
 * object. Always use `OOP` instead of raw pointers `Object*` in VM
 * code - `OOP` are (will be) safe w.r.t moving GC.
 */

template<typename T = VMObject>
class OOP
{
  public:
    /* Create a new NULL reference.  */
    OOP()
      : ptr(NULL)
    {}

    /* Create a new NULL reference.  Note that this is not explicit.  */
    OOP(const std::nullptr_t)
      : ptr(NULL)
    {}

    /* Create a new reference to an object `obj` */
    OOP(VMObject* obj)
      : ptr(reinterpret_cast<T*>(obj))
    {}

    /* Create a new reference to an object `obj` */
    OOP(void* obj)
      : ptr(reinterpret_cast<T*>(obj))
    {}

    /* Create a new reference from another reference */
    template<typename U>
    OOP(OOP<U> oop)
      : ptr(reinterpret_cast<T*>(oop.get()))
    {}

    /* Destroy this reference.  */
    ~OOP() {}

    /* Change this reference to bew object. Use with caution! */
    void reset(T* obj) { ptr = obj; }

    /* Return referent */
    T* get() const { return ptr; }

    /* Return referent, and stop managing this reference. */
    T* release()
    {
        T* result = ptr;

        ptr = NULL;
        return result;
    }

    /* Let users refer to members of the underlying pointer.  */
    T* operator->() const { return ptr; }

  private:
    T* ptr;
};

template<typename T, typename U>
inline bool
operator==(const OOP<T>& lhs, const OOP<U>& rhs)
{
    return lhs.get() == rhs.get();
}

template<typename T, typename U>
inline bool
operator==(const OOP<T>& lhs, const U* rhs)
{
    return lhs.get() == rhs;
}

template<typename T>
inline bool
operator==(const OOP<T>& lhs, const std::nullptr_t)
{
    return lhs.get() == nullptr;
}

template<typename T, typename U>
inline bool
operator==(const T* lhs, const OOP<U>& rhs)
{
    return lhs == rhs.get();
}

template<typename U>
inline bool
operator==(const std::nullptr_t, const OOP<U>& rhs)
{
    return nullptr == rhs.get();
}

template<typename T, typename U>
inline bool
operator!=(const OOP<T>& lhs, const OOP<U>& rhs)
{
    return lhs.get() != rhs.get();
}

template<typename T, typename U>
inline bool
operator!=(const OOP<T>& lhs, const U* rhs)
{
    return lhs.get() != rhs;
}

template<typename T>
inline bool
operator!=(const OOP<T>& lhs, const std::nullptr_t)
{
    return lhs.get() != nullptr;
}

template<typename T, typename U>
inline bool
operator!=(const T* lhs, const OOP<U>& rhs)
{
    return lhs != rhs.get();
}

template<typename U>
inline bool
operator!=(const std::nullptr_t, const OOP<U>& rhs)
{
    return nullptr != rhs.get();
}

extern OOP<VMObject> SpecialObjectsArray;
extern OOP<VMObject> Nil;
extern OOP<VMObject> True;
extern OOP<VMObject> False;
extern OOP<VMObject> Class_SmallInteger;
extern OOP<VMObject> Symbol_evaluate;

} // namespace S9

#endif /* _OBJECT_H_ */
