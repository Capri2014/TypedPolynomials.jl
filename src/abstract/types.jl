abstract type AbstractVariable{Name} end
@pure name(::Type{<:AbstractVariable{N}}) where {N} = N
@pure name(v::AbstractVariable) = name(typeof(v))
@pure degree(::AbstractVariable) = 1
@pure nvars(::AbstractVariable) = 1

abstract type AbstractMonomial{Variables} end
degree(m::AbstractMonomial) = sum(exponents(m))
@pure variables(::Type{<:AbstractMonomial{V}}) where {V} = V
@pure variables(m::AbstractMonomial) = variables(typeof(m))
@pure nvars(::Type{<:AbstractMonomial{V}}) where {V} = length(V)
@pure nvars(m::AbstractMonomial) = nvars(typeof(m))
function exponents end
function exponent end

abstract type AbstractTerm{CoeffType, MonomialType} end
monomialtype(::Type{<:AbstractTerm{C, M}}) where {C, M} = M
monomialtype(t::AbstractTerm) = monomialtype(typeof(t))
degree(t::AbstractTerm) = degree(monomial(t))
variables(T::Type{<:AbstractTerm}) = variables(monomialtype(T))
variables(t::AbstractTerm) = variables(monomialtype(t))
exponents(t::AbstractTerm) = exponents(monomial(t))
exponent(t::AbstractTerm, v::AbstractVariable) = exponent(monomial(t), v)
powers(m::AbstractMonomial) = tuplezip(variables(m), exponents(m))
nvars(t::AbstractTerm{C, M}) where {C, M} = nvars(M)
function coefficient end
function monomial end

abstract type AbstractPolynomial end
nvars(p::AbstractPolynomial) = maximum(nvars, terms(p))
maxdeg(p::AbstractPolynomial) = maximum(degree, terms(p))
mindeg(p::AbstractPolynomial) = minimum(degree, terms(p))
extdeg(p::AbstractPolynomial) = (mindeg(p), maxdeg(p))
# termtype(::Type{<:AbstractPolynomial{T}}) where {T} = T
# termtype(p::AbstractPolynomial) = termtype(typeof(p))
function terms end
function variables end
# variables(T::Type{<:AbstractPolynomial}) = variables(termtype(T))
# variables(p::AbstractPolynomial) = variables(termtype(p))

const AbstractMonomialLike = Union{<:AbstractVariable, <:AbstractMonomial}
const AbstractTermLike = Union{<:AbstractMonomialLike, <:AbstractTerm}
const AbstractPolynomialLike = Union{<:AbstractTermLike, <:AbstractPolynomial}
